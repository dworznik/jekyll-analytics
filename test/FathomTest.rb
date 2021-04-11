require_relative "../lib/analytics/Fathom.rb"
require "test/unit"

class TestFathom < Test::Unit::TestCase
    def test_init
        assert_raise( ArgumentError ) { Fathom.new( {"id" => "123-456"} ) }
        assert_instance_of(Fathom, Fathom.new( {"id" => "ABCDE"} ))
    end

    def test_default_tracking_string
        fathom = Fathom.new( {"id" => "ABCDE", "domain" => "example.org"} )
        assert_equal(fathom.render(), 
        """
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
    })(document, window, '//example.org/tracker.js', 'fathom');
\tfathom('set', 'siteId', 'ABCDE');
\tfathom('trackPageview');
    </script>
    <!-- / Fathom -->
    """)
    end
end