(function () {
    'use strict';

    var IOClass = function (options) {
        this.init(options);
    };

    IOClass.DEFAULTS = {
        baseUrl: '',
        ioUrl: ''
    };

    IOClass.prototype = {

        constructor: IOClass,

        init: function (options) {
            this.options = $.extend({}, IOClass.DEFAULTS, options);
        },

        call: function (name, params, context, callback) {
            var data = {'name': name, 'params': params};
            this.request(data, context, callback);
        },

        request: function (req, context, callback) {
            var that = this;

            $.evo.trigger('load.io.request', { req: req });

            return $.ajax({
                type: "POST",
                dataType: "json",
                url: this.options.ioUrl,
                data: {'io': JSON.stringify(req)},
                success: function (data, textStatus, jqXHR) {
                    that.handleResponse(data, context);
                    if (typeof callback === 'function') {
                        callback(false, context);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    that.handleError(textStatus, errorThrown);
                    if (typeof callback === 'function') {
                        callback(true, textStatus);
                    }
                },
                complete: function(jqXHR, textStatus) {
                    $.evo.trigger('loaded.io.request', {
                        req: req,
                        status: textStatus
                    });
                }
            });
        },

        handleResponse: function (data, context)
        {
            if(data.domAssigns) {
                data.domAssigns.forEach(item => {
                    let $item = $('#' + item.target);

                    if ($item.length > 0) {
                        $item[0][item.attr] = item.data;
                    }
                });
            }

            if (!context) {
                context = this;
            }

            if(data.debugLogLines) {
                data.debugLogLines.forEach(line => {
                    if(line[1]) {
                        console.groupCollapsed(...line[0]);
                    }
                    else if(line[2]) {
                        console.groupEnd();
                    }
                    else {
                        console.log(...line[0]);
                    }
                });
            }

            if(data.evoProductCalls) {
                data.evoProductCalls.forEach(([name, args]) => {
                    $.evo.article()[name](...args);
                });
            }

            if(data.varAssigns) {
                data.varAssigns.forEach(assign => {
                    context[assign.name] = assign.value;
                });
            }

            if(data.windowLocationHref) {
                window.location.href = data.windowLocationHref;
            }
        },

        handleError: function (textStatus, errorThrown) {
            $.evo.error('handleError', textStatus, errorThrown);
        },

        getFormValues: function (parent) {
            return $('#' + parent).serializeObject();
        },
    };

    // PLUGIN DEFINITION
    // =================

    $.evo.io = function() {
        return new IOClass({
            'ioUrl': $('#jtl-io-path').data('path') + '/io.php'
        });
    };
})(jQuery);
