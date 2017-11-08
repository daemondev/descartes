function onClose() {
    //change this with your desired image url from your image upload tool
    var imgUrl = "https://ilmubarokah.files.wordpress.com/2014/02/myblog2.png?w=360";
    var result = "&lt;img src=" + imgUrl + " style='width:auto;heigth:auto;'&gt;";
    var element = window.opener.CKEDITOR.dom.element.createFromHtml(result);
    var CKEDITOR = window.opener.CKEDITOR;
    for (var i in CKEDITOR.instances) {
        var currentInstance = i;
        break;
    }
    var oEditor = window.opener.CKEDITOR.instances[currentInstance];
    oEditor.insertElement(element);
    window.close();
}

CKEDITOR.editorConfig = function (config) {

    // add these line
    config.extraPlugins = 'custimage'; //enable custimage tool button
    config.removePlugins = 'image'; //disable default image tool button

}

//https://ilmubarokah.wordpress.com/2014/02/17/ckeditor-custom-image-dialog-plugin/

onShow:function(){
    CKEDITOR.dialog.getCurrent().hide(); 
    var $myDlg= $('<div></div>').load('backstage/ckeimage/imgform.jsp');
    //change load parameter with html (which has form on it, and use ajax upload and json data to get get the image url back)
    $myDlg.dialog({
        modal:true,
        width:640,
        height:480,
        open:function(event,ui) {
            //$('.dpc').datepicker();                   
        },
        close:function() {
 
            // The context of this function is the dialog object itself.
            // http://docs.ckeditor.com/#!/api/CKEDITOR.dialog
            var dialog = this;
 
            // Creates a new <img> element.
            var custimage = editor.document.createElement( 'img' );
 
            // Set element attribute and text, by getting the defined field values.
            custimage.setAttribute( 'src', 'abc' );
            custimage.setAttribute( 'alt', 'def' );
            //custimage.setText( dialog.getValueOf( 'tab-basic', 'alt' ) );
 
            // Finally, inserts the element at the editor caret position.
            editor.insertElement( custimage );
            $myDlg.remove();
        }
 
    });
},
//https://ilmubarokah.wordpress.com/2014/02/17/ckeditor-custom-image-dialog-plugin/



I would tend to think that I need to add my variable in the ckeditor.js code where the call to custimage resides:
    CKEDITOR.plugins.add(“custimage”,{icons:”custimage”,init:function(a){ a.addCommand(“custimage”,new CKEDITOR.dialogCommand(“custimageDialog”));a.ui.addButton(“custimage”,{label:a.lang.common.image,command:”custimage”,toolbar:”insert”});CKEDITOR.dialog.add(“custimageDialog”,this.path+”dialogs/custimage.js”); }});
I haven’t figured out how to add it here without breaking the code.
Reply