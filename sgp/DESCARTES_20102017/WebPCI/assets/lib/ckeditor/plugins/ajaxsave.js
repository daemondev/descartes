CKEDITOR.plugins.add('ajaxsave',
    {
        init: function (editor) {
            var pluginName = 'ajaxsave';

            editor.addCommand(pluginName,
                {
                    exec: function (editor) {
                        new Ajax.Request('ajaxsave.php',
                            {
                                method: "POST",
                                parameters: { filename: 'index.html', editor: editor.getData() },
                                onFailure: function () { ThrowError("Error: The server has returned an unknown error"); },
                                on0: function () { ThrowError('Error: The server is not responding. Please try again.'); },
                                onSuccess: function (transport) {

                                    var resp = transport.responseText;

                                    //Successful processing by ckprocess.php should return simply 'OK'. 
                                    if (resp == "OK") {
                                        //This is a custom function I wrote to display messages. Nicer than alert() 
                                        ShowPageMessage('Changes have been saved successfully!');
                                    } else {
                                        ShowPageMessage(resp, '10');
                                    }
                                }
                            });
                    },

                    canUndo: true
                });

            editor.ui.addButton('ajaxsave',
                {
                    label: 'Save',
                    command: pluginName,
                    className: 'cke_button_save'
                });
        }
    });