Битые ссылки удобно проверять питоновским LinkChecker-ом

Установка:
pip install LinkChecker


Использование:
linkchecker http://site.com 

По linkchecker --help 
Можно увидить множество вариантов:

General options:
  -f FILENAME, --config FILENAME
                        Use FILENAME as configuration file. Per default
                        LinkChecker uses ~/.linkchecker/linkcheckerrc (under
                        Windows %HOMEPATH%\.linkchecker\linkcheckerrc).
  -t NUMBER, --threads NUMBER
                        Generate no more than the given number of threads.
                        Default number of threads is 10. To disable threading
                        specify a non-positive number.
  -V, --version         Print version and exit.
  --list-plugins        Print available check plugins and exit.
  --stdin               Read list of white-space separated URLs to check from
                        stdin.

Output options:
  -D STRING, --debug STRING
                        Print debugging output for the given logger. Available
                        loggers are 'gui', 'thread', 'cmdline', 'plugin',
                        'checking', 'all', 'cache'. Specifying 'all' is an
                        alias for specifying all available loggers. The option
                        can be given multiple times to debug with more than
                        one logger. For accurate results, threading will be
                        disabled during debug runs.
  -F TYPE[/ENCODING[/FILENAME]], --file-output TYPE[/ENCODING[/FILENAME]]
                        Output to a file linkchecker-out.TYPE,
                        $HOME/.linkchecker/blacklist for 'blacklist' output,
                        or FILENAME if specified. The ENCODING specifies the
                        output encoding, the default is that of your locale.
                        Valid encodings are listed at
                        http://docs.python.org/lib/standard-encodings.html.
                        The FILENAME and ENCODING parts of the 'none' output
                        type will be ignored, else if the file already exists,
                        it will be overwritten. You can specify this option
                        more than once. Valid file output types are
                        'blacklist', 'sitemap', 'sql', 'xml', 'csv', 'none',
                        'dot', 'gxml', 'html', 'gml', 'text'. You can specify
                        this option multiple times to output to more than one
                        file. Default is no file output. Note that you can
                        suppress all console output with the option '-o none'.
  --no-status           Do not print check status messages.
  --no-warnings         Don't log warnings. Default is to log warnings.
  -o TYPE[/ENCODING], --output TYPE[/ENCODING]
                        Specify output as 'blacklist', 'sitemap', 'sql',
                        'xml', 'csv', 'none', 'dot', 'gxml', 'html', 'gml',
                        'text'. Default output type is text. The ENCODING
                        specifies the output encoding, the default is that of
                        your locale. Valid encodings are listed at
                        http://docs.python.org/lib/standard-encodings.html.
  -q, --quiet           Quiet operation, an alias for '-o none'. This is only
                        useful with -F.
  -v, --verbose         Log all URLs. Default is to log only errors and
                        warnings.

Checking options:
  --cookiefile FILENAME
                        Read a file with initial cookie data. The cookie data
                        format is explained below.
  --check-extern        Check external URLs.
  --ignore-url REGEX    Only check syntax of URLs matching the given regular
                        expression. This option can be given multiple times.
  --no-follow-url REGEX
                        Check but do not recurse into URLs matching the given
                        regular expression. This option can be given multiple
                        times.
  -N STRING, --nntp-server STRING
                        Specify an NNTP server for 'news:...' links. Default
                        is the environment variable NNTP_SERVER. If no host is
                        given, only the syntax of the link is checked.
  -p, --password        Read a password from console and use it for HTTP and
                        FTP authorization. For FTP the default password is
                        'anonymous@'. For HTTP there is no default password.
                        See also -u.
  -r NUMBER, --recursion-level NUMBER
                        Check recursively all links up to given depth. A
                        negative depth will enable infinite recursion. Default
                        depth is infinite.
  --timeout NUMBER      Set the timeout for connection attempts in seconds.
                        The default timeout is 60 seconds.
  -u STRING, --user STRING
                        Try the given username for HTTP and FTP authorization.
                        For FTP the default username is 'anonymous'. For HTTP
                        there is no default username. See also -p.
  --user-agent STRING   Specify the User-Agent string to send to the HTTP
                        server, for example "Mozilla/4.0". The default is
                        "LinkChecker/X.Y" where X.Y is the current version of
		LinkChecker.



