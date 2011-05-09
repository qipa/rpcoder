/* generated by rpcoder */

package foo.bar
{
    import mx.rpc.AsyncResponder;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.http.HTTPService;
    import com.adobe.serialization.json.JSON;

    public class API
    {
        public static const CONTINUE :int                        = 100;
        public static const SWITCHING_PROTOCOLS :int             = 101;
        public static const PROCESSING :int                      = 102;
        public static const OK :int                              = 200;
        public static const CREATED :int                         = 201;
        public static const ACCEPTED :int                        = 202;
        public static const NON_AUTHORITATIVE_INFORMATION :int   = 203;
        public static const NO_CONTENT :int                      = 204;
        public static const RESET_CONTENT :int                   = 205;
        public static const PARTIAL_CONTENT :int                 = 206;
        public static const MULTI_STATUS :int                    = 207;
        public static const IM_USED :int                         = 226;
        public static const MULTIPLE_CHOICES :int                = 300;
        public static const MOVED_PERMANENTLY :int               = 301;
        public static const FOUND :int                           = 302;
        public static const SEE_OTHER :int                       = 303;
        public static const NOT_MODIFIED :int                    = 304;
        public static const USE_PROXY :int                       = 305;
        public static const RESERVED :int                        = 306;
        public static const TEMPORARY_REDIRECT :int              = 307;
        public static const BAD_REQUEST :int                     = 400;
        public static const UNAUTHORIZED :int                    = 401;
        public static const PAYMENT_REQUIRED :int                = 402;
        public static const FORBIDDEN :int                       = 403;
        public static const NOT_FOUND :int                       = 404;
        public static const METHOD_NOT_ALLOWED :int              = 405;
        public static const NOT_ACCEPTABLE :int                  = 406;
        public static const PROXY_AUTHENTICATION_REQUIRED :int   = 407;
        public static const REQUEST_TIMEOUT :int                 = 408;
        public static const CONFLICT :int                        = 409;
        public static const GONE :int                            = 410;
        public static const LENGTH_REQUIRED :int                 = 411;
        public static const PRECONDITION_FAILED :int             = 412;
        public static const REQUEST_ENTITY_TOO_LARGE :int        = 413;
        public static const REQUEST_URI_TOO_LONG :int            = 414;
        public static const UNSUPPORTED_MEDIA_TYPE :int          = 415;
        public static const REQUESTED_RANGE_NOT_SATISFIABLE :int = 416;
        public static const EXPECTATION_FAILED :int              = 417;
        public static const UNPROCESSABLE_ENTITY :int            = 422;
        public static const LOCKED :int                          = 423;
        public static const FAILED_DEPENDENCY :int               = 424;
        public static const UPGRADE_REQUIRED :int                = 426;
        public static const INTERNAL_SERVER_ERROR :int           = 500;
        public static const NOT_IMPLEMENTED :int                 = 501;
        public static const BAD_GATEWAY :int                     = 502;
        public static const SERVICE_UNAVAILABLE :int             = 503;
        public static const GATEWAY_TIMEOUT :int                 = 504;
        public static const HTTP_VERSION_NOT_SUPPORTED :int      = 505;
        public static const VARIANT_ALSO_NEGOTIATES :int         = 506;
        public static const INSUFFICIENT_STORAGE :int            = 507;
        public static const NOT_EXTENDED :int                    = 510;

        private var _baseUrl:String;
        private var _errorHandler : Function;

        public function API(baseUrl:String)
        {
            this._baseUrl = baseUrl;
        }

        public function get baseUrl():String
        {
            return this._baseUrl;
        }

        public function set errorHandler(handler : Function):void
        {
            this._errorHandler = handler;
        }

        public function get errorHandler():Function
        {
            return this._errorHandler;
        }

        /**
        * get mail
        *
        * @id:int  
        * @foo:String ["A", "B"] 
        * @bar:Array  
        * @baz:Boolean  日本の文字
        * @success:Function
        * @error:Function
        */
        public function getMail(id:int, foo:String, bar:Array, baz:Boolean, success:Function, error:Function):void
        {
            var params:Object = {"foo":foo, "bar":bar, "baz":baz};
            request("GET", "/mails/" + id, params,
                function(e:ResultEvent, t:Object):void {
                    t = t; // FIXME: for removing warning
                    var hash:Object = JSON.decode(e.result as String);


                    success(new Mail(hash['mail']));
                },
                function(e:FaultEvent, t:Object):void {
                    t = t; // FIXME: for removing warning
                    error(e);
                }
            );
        }

        /**
        * get mails
        *
        * @success:Function
        * @error:Function
        */
        public function getMails(success:Function, error:Function):void
        {
            var params:Object = {};
            request("GET", "/mails/", params,
                function(e:ResultEvent, t:Object):void {
                    t = t; // FIXME: for removing warning
                    var hash:Object = JSON.decode(e.result as String);

                    var mails_list:Array = new Array();
                    for each (var mails:Object in hash['mails'])
                        mails_list.push(new Mail(mails));

                    success(mails_list, hash['count']);
                },
                function(e:FaultEvent, t:Object):void {
                    t = t; // FIXME: for removing warning
                    error(e);
                }
            );
        }

        public function request(method:String, path:String, params:Object, success:Function, error:Function):void
        {
            var service:HTTPService = createHttpService(this.baseUrl);
            service.method = method;
            service.url = path;
            service.request = params;
            service.resultFormat = 'text';
            var token:AsyncToken = service.send();
            token.addResponder(new AsyncResponder(
                success,
                function(e:FaultEvent, t:Object):void {
                    if (_errorHandler !== null && e.statusCode >= 500) {
                        _errorHandler(e, t);
                    } else {
                        error(e, t);
                    }
                }
            ));
        }

        public function createHttpService(baseUrl:String) : HTTPService
        {
            return new HTTPService(baseUrl);
        }
    }
}
