class Fathom 
    #source: https://developers.google.com/analytics/devguides/collection/analyticsjs/
    SETUP_CODE = """
    <!-- Fathom - simple website analytics - https://github.com/usefathom/fathom -->
    <script>
    (function(f, a, t, h, o, m){
        a[h]=a[h]||function(){
            (a[h].q=a[h].q||[]).push(arguments)
        };
        o=f.createElement('script'),
        m=f.getElementsByTagName('script')[0];
        o.async=1; o.src=t; o.id='fathom-script';
        m.parentNode.insertBefore(o,m)
    })%s
    </script>
    <!-- / Fathom -->
    """

    ID_RE = /^[A-Z]{5}$/    
    DOMAIN_CODE = "(document, window, '//%s/tracker.js', 'fathom');"
    INITIALIZE_CODE = "fathom('set', 'siteId', '%s');"
    PAGEVIEW_CODE = "fathom('trackPageview');"


   def initialize(config)
        if !(ID_RE.match(config["id"]))
            raise ArgumentError, 'Invalid Fathom code. Id must look like UVXYZ'
        end

        @commands = []
        @commands.push(DOMAIN_CODE % config["domain"])
        @commands.push(INITIALIZE_CODE % config["id"])
        @commands.push(PAGEVIEW_CODE)
    end

    def render()
        return SETUP_CODE % @commands.join("\n\t")
    end
end