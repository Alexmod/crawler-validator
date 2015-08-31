#!/usr/bin/env perl
use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);
use Mojo::UserAgent;
use List::MoreUtils 'true';
use Term::ANSIColor;

# Адрес сайта для проверки
my $site_to_check = 'http://habrahabr.ru';

# Адрес локального валидатора
my $local_validator = 'http://192.168.1.217:8888';

# FIFO queue
my @urls = ( Mojo::URL->new($site_to_check) );

# User agent following up to 5 redirects
my $ua = Mojo::UserAgent->new( max_redirects => 5 );

# Track accessed URLs
my $active = 0;
my %uniq;

sub parse {
    my ($tx) = @_;

    # Request URL
    my $url = $tx->req->url;

    # Extract and enqueue URLs
    for my $e ( $tx->res->dom('a[href]')->each ) {

        # Validate href attribute
        my $link = Mojo::URL->new( $e->{href} );
        next if 'Mojo::URL' ne ref $link;

        # "normalize" link
        $link = $link->to_abs( $tx->req->url )->fragment(undef);
        next unless $link->protocol =~ /^https?$/x;

        # Don't go deeper than /a/b/c
        next if @{ $link->path->parts } > 3;

        # Access every link only once
        next if ++$uniq{ $link->to_string } > 1;

        # Don't visit other hosts
        next if $link->host ne $url->host;

        push @urls, $link;
        my $get   = $ua->get( $local_validator . "?doc=$link" )->res->body;
        my @answ  = split / /, $get;
        my $count = true { /class="error"/ } @answ;
        print color("green"), $link, color("reset");
        print "  Кол-во ошибок в валидаторе: ",
          color("red"), "$count \n", color("reset");

    }

    return;
}

sub get_callback {
    my ( undef, $tx ) = @_;

    # Parse only OK HTML responses
    $tx->res->code == 200
      and $tx->res->headers->content_type =~ m{^text/html\b}ix
      and parse($tx);

    # Deactivate
    --$active;

    return;
}

Mojo::IOLoop->recurring(
    0 => sub {

        # Keep up to 4 parallel crawlers sharing the same user agent
        for ( $active .. 4 - 1 ) {

            # Dequeue or halt if there are no active crawlers anymore
            return ( $active or Mojo::IOLoop->stop )
              unless my $url = shift @urls;

            # Fetch non-blocking just by adding
            # a callback and marking as active
            ++$active;
            $ua->get( $url => \&get_callback );
        }
    }
);

# Start event loop if necessary
Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
