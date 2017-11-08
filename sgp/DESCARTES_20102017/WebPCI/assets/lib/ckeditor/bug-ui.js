<!DOCTYPE html>
<html>
<head>
       <title>Ajax &mdash; CKEditor Sample</title>
       <meta content="text/html; charset=utf-8" http-equiv="content-type" />   
      
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
    
            <script type="text/javascript">
$.widget( "ui.dialog", $.ui.dialog, {
 /*! jQuery UI - v1.10.2 - 2013-12-12
  *  http://bugs.jqueryui.com/ticket/9087#comment:27 - bugfix
  *  http://bugs.jqueryui.com/ticket/4727#comment:23 - bugfix
  *  allowInteraction fix to accommodate windowed editors
  */
  _allowInteraction: function( event ) {
    if ( this._super( event ) ) {
      return true;
    }

    // address interaction issues with general iframes with the dialog
    if ( event.target.ownerDocument != this.document[ 0 ] ) {
      return true;
    }

    // address interaction issues with dialog window
    if ( $( event.target ).closest( ".cke_dialog" ).length ) {
      return true;
    }

    // address interaction issues with iframe based drop downs in IE
    if ( $( event.target ).closest( ".cke" ).length ) {
      return true;
    }
  },
 /*! jQuery UI - v1.10.2 - 2013-10-28
  *  http://dev.ckeditor.com/ticket/10269 - bugfix
  *  moveToTop fix to accommodate windowed editors
  */
  _moveToTop: function ( event, silent ) {
    if ( !event || !this.options.modal ) {
      this._super( event, silent );
    }
  }
});
    </script>
    
        <script type="text/javascript" src="http://cdn.skatrix.com/tools/ckeditor/4.3.1/ckeditor.js"></script>


        <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/smoothness/jquery-ui.css" />

</head>
<body>
        <script type="text/javascript">
  
            
            
var editor, html = '';
var config = {};
	
function createEditor()
{
        if ( editor )
                return;

        $("#editor").bind('dialogopen', function() //JQ
        {
                editor = CKEDITOR.replace('editor1', config, 'aaa');
        }).bind('dialogclose', function()
        {
                removeEditor();//CK
                $(this).dialog('destroy');
        })
        .dialog({autoOpen: false,
                maxHeight:0.95 * $(window).height(),//1
                width: 800,
                modal: true,
                position: 'top',
                resizable: false,
                autoResize: true }).dialog('open');
}

function removeEditor()
{
        if ( !editor )
                return;

        // Destroy the editor.
        editor.destroy();
        editor = null;
}
    </script>
        <p>Click the buttons to create jquery dialog and CKEditor instance.</p>
        <p>
                <input onclick="createEditor();" type="button" value="Create Editor" />
        </p>
        <div id="editor">
            <textarea id="editor1" ><a href="/"
>click me</a></textarea>
         
        </div>
</body>
</html>
