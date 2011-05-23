/* generated by rpcoder */

package foo.bar
{
    import mx.rpc.events.FaultEvent;

    public class APIDummy implements APIInterface
    {
        private var _baseUrl:String;
        private var _errorHandler : Function;

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

        private var _errors:Array = new Array();
        private var _dummy_success:Array = new Array();

        public function setDummySuccess(function_name:String, success:Array):void
        {
            _dummy_success[function_name] = success;
        }

        private function getDummySuccess(function_name:String):Array
        {
            return _dummy_success[function_name];
        }

        public function setDummyError(function_name:String, is_error:Boolean):void
        {
            _errors[function_name] = is_error;
        }

        private function isError(function_name:String):Boolean
        {
            return _errors[function_name];
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
        public function getMail(id:int, foo:String, bar:Array, baz:Boolean, success:Function, error:Function = null):void
        {
            requestDummy('getMail', success, error);
        }

        /**
        * get mails
        *
        * @success:Function
        * @error:Function
        */
        public function getMails(success:Function, error:Function = null):void
        {
            requestDummy('getMails', success, error);
        }

        public function requestDummy(function_name:String, success:Function, error:Function):void
        {
            if ( isError(function_name) )
            {
                var e:FaultEvent = new FaultEvent("dummy fault");
                var t:Object = this;
                var handler : Function;
                if (error !== null) {
                    handler = error;
                } else {
                    handler = _errorHandler;
                }
                switch ( handler.length )
                {
                    case 0:
                        handler.call(this);
                        break;
                    case 1:
                        handler.call(this, e);
                        break;
                    case 2:
                        handler.call(this, e, t);
                        break;
                }
            }
            else
            {
                success.apply(this, getDummySuccess(function_name));
            }
        }
    }
}
