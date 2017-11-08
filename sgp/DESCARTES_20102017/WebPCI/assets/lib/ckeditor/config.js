/*
CKEDITOR.editorConfig = function (config) {
    config.toolbarGroups = [
		{ name: 'document', groups: ['mode', 'document', 'doctools'] },
		{ name: 'clipboard', groups: ['clipboard', 'undo'] },
		{ name: 'editing', groups: ['find', 'selection', 'spellchecker', 'editing'] },
		{ name: 'forms', groups: ['forms'] },
		{ name: 'basicstyles', groups: ['basicstyles', 'cleanup'] },
		{ name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] },
		{ name: 'links', groups: ['links'] },
		{ name: 'insert', groups: ['insert'] },
		{ name: 'styles', groups: ['styles'] },
		{ name: 'colors', groups: ['colors'] },
		{ name: 'tools', groups: ['tools'] },
		{ name: 'others', groups: ['others'] },
		{ name: 'about', groups: ['about'] }
    ];

    config.removeButtons = 'Anchor,Subscript,Superscript';
}; //*/
/*
CKEDITOR.editorConfig = function (config) {
    config.toolbarGroups = [
		{ name: 'document', groups: ['mode', 'document', 'doctools'] },
		{ name: 'clipboard', groups: ['clipboard', 'undo'] },
		{ name: 'forms', groups: ['forms'] },
		{ name: 'colors', groups: ['colors'] },
		{ name: 'basicstyles', groups: ['basicstyles', 'cleanup'] },
		{ name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] },
		{ name: 'links', groups: ['links'] },
		{ name: 'insert', groups: ['insert'] },
		{ name: 'editing', groups: ['selection', 'find', 'spellchecker', 'editing'] },
		{ name: 'styles', groups: ['styles'] },
		{ name: 'tools', groups: ['tools'] },
		{ name: 'others', groups: ['others'] },
		{ name: 'about', groups: ['about'] }
    ];

    config.removeButtons = 'Anchor,Subscript,Superscript,PasteFromWord,PasteText,Find,Replace';
};//*/

//var config = { toolbar: [['Bold', 'Italic', '-', 'Link', 'Unlink', 'Copy']] };
//CKEDITOR.config.toolbar = eval(config);
// Load a specific configuration file.
/*
https://docs-old.ckeditor.com/ckfinder_2.x_api/symbols/CKFinder.config.html#.customConfig
https://docs-old.ckeditor.com/CKFinder_2.x/Developers_Guide/PHP/CKEditor_Integration#Enabling_CKFinder
https://docs-old.ckeditor.com/File:CKEditor_Image_Dialog.png
filebrowserUploadUrl = "base64";
CKFinder.create({ basePath: '/ckfinder/', customConfig: '/myconfig.js' });

config.templates_files = [ '/mytemplates.js' ];

For your specific notation, the line would be:

templates_files: [ '/mytemplates1.js', '/mytemplates2.js' ]

// Do not load any custom configuration file.
CKFinder.create({ basePath: '/ckfinder/', customConfig: '' });

//##############


    You can specif settings in config file that are default initializations for any editor created.

    CKEDITOR.editorConfig = function(config) {
    config.forcePasteAsPlainText = false;
    ...
    }

    You can override the config settings in this way so only the editor initialized will get these changes.

    CKEDITOR.replace('myEditor', { forcePasteAsPlainText: ture });

    You can also use editor destroy and recreate with custom configs.

    var editor = CKEDITOR.instances.myEditor;
    if (editor) { editor.destroy(true); }
    CKEDITOR.config.forcePasteAsPlainText = false;
    CKEDITOR.config.width = 400;
    CKEDITOR.config.height = 300;

    CKEDITOR.replace('myEditor', CKEDITOR.config);


//*/
//config.extraPlugins = 'base64image';
//https://docs-old.ckeditor.com/ckeditor_api/symbols/CKEDITOR.config.html#constructor

/*
 config.toolbar_Full =
[
    { name: 'document', items: ['Source', '-', 'Save', 'NewPage', 'DocProps', 'Preview', 'Print', '-', 'Templates'] },
    { name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo'] },
    { name: 'editing', items: ['Find', 'Replace', '-', 'SelectAll', '-', 'SpellChecker', 'Scayt'] },
    { name: 'forms', items: ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'] },
    '/',
    { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat'] },
    { name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl'] },
    { name: 'links', items: ['Link', 'Unlink', 'Anchor'] },
    { name: 'insert', items: ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak'] },
    '/',
    { name: 'styles', items: ['Styles', 'Format', 'Font', 'FontSize'] },
    { name: 'colors', items: ['TextColor', 'BGColor'] },
    { name: 'tools', items: ['Maximize', 'ShowBlocks', '-', 'About'] }
];
*/

///*
CKEDITOR.editorConfig = function (config) {
    config.toolbarGroups = [
		  { name: 'document', groups: ['mode', 'document', 'doctools'] }
        , { name: 'clipboard', groups: ['selection', 'clipboard', 'undo', 'find'] } //cut
        , { name: 'colors', groups: ['colors'] }
        , { name: 'basicstyles', groups: ['basicstyles', 'cleanup'] } //bold
		, { name: 'styles', groups: ['styles'] } //font        		
        , { name: 'tools', groups: ['tools'] }
		, { name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] }        
        , { name: 'editing', groups: [ 'spellchecker', 'editing'] }
        //, { name: 'editing', groups: ['selection', 'find', 'spellchecker', 'editing'] }
        //, { name: 'links', groups: ['links'] }        
		, { name: 'insert', groups: ['insert'] }		
		//, { name: 'links', groups: ['links'] }
        , { name: 'forms', groups: ['form', 'forms', 'links'] }
		//, { name: 'others', groups: ['others'] }
		//, { name: 'about', groups: ['about'] }
    ];

    config.removeButtons = 'Anchor,Subscript,Superscript,PasteText,Print,ShowBlocks,Find,SpellChecker,Smiley,Emojione'; //Link,Unlink,
    //config.filebrowserUploadUrl = "base64";
    config.toolbarCanCollapse = true;
    //config.toolbarLocation = 'bottom';
    config.toolbarStartupExpanded = false;
    //config.uiColor = '#57A581';
    config.uiColor = '#D43F3A';
    config.useComputedState = false;
    config.filebrowserBrowseUrl = 'Browserhandler.ashx';
    config.filebrowserUploadUrl = 'UploadHandler.ashx';
    //config.extraPlugins = 'uploadimage';
    //config.extraPlugins = 'filebrowser,uploadimage,div,menu,contextmenu,panel,floatpanel';
    //config.extraPlugins = 'filebrowser,uploadimage,div,table,tabletools,tableresize,dialogadvtab';
    config.extraPlugins = 'filebrowser,uploadimage,div,table,tabletools,tableresize,pastefromexcel,colordialog,autogrow,forms,label,extraformattributes,image2,stylescombo'; //,divarea
    config.filebrowserWindowWidth = '640';
    config.filebrowserWindowHeight = '480';
    config.div_wrapTable = true;
    config.colorButton_colors = '000,800000,8B4513,2F4F4F,008080,000080,4B0082,696969,' +
        'B22222,A52A2A,DAA520,006400,40E0D0,0000CD,800080,808080,' +
        'F00,FF8C00,FFD700,008000,0FF,00F,EE82EE,A9A9A9,' +
        'FFA07A,FFA500,FFFF00,00FF00,AFEEEE,ADD8E6,DDA0DD,D3D3D3,' +
        'FFF0F5,FAEBD7,FFFFE0,F0FFF0,F0FFFF,F0F8FF,E6E6FA,FFF,000';
    //config.enterMode = CKEDITOR.ENTER_BR;
    //config.format_div = { element: 'div', attributes: { 'class': 'doc' } };

    //config.extraAllowedContent = 'u;span{color}';
    //FCKeditorAPI.GetInstance('MEDesc').EditorDocument.body.innerHTML = 'this is my text';
    config.pasteFromWordRemoveStyles = false;
    config.pasteFromWordRemoveFontStyles = false;    
    config.allowedContent = true;

    config.autoGrow_minHeight = 200;
    config.autoGrow_maxHeight = 430;
    config.autoGrow_bottomSpace = 50;
    config.autoGrow_onStartup = true;
    //config.keystrokes = [[CKEDITOR.CTRL + 86, 'pastetext'], [CKEDITOR.CTRL + CKEDITOR.SHIFT + 86, 'paste']];
    //config.forcePasteAsPlainText = true;
    /*
    config.filebrowserBrowseUrl= '/ckfinder/ckfinder.html';
    config.filebrowserImageBrowseUrl= '/ckfinder/ckfinder.html?type=Images';
    config.filebrowserUploadUrl= '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files';
    config.filebrowserImageUploadUrl= '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images'; //*/
    //config.menu_groups = 'clipboard,table,anchor,link,image';
    //config.pasteFromWordRemoveStyles = false;

    //CKEDITOR.addCss(".cke_editable{background-color: red}");
    /*
    config.templates_files =
    [
        '/templates/site_default.js',
        'http://localhost/templates.js'
    ];
    config.templates = 'my_templates'; //*/
};  //*/
//http://jschr.github.io/bootstrap-modal/
//https://ckeditor.com/old/forums/Support/Issue-with-Twitter-Bootstrap#comment-127719
//https://docs.ckeditor.com/ckeditor4/docs/#!/guide/dev_howtos_dialog_windows
//https://docs.ckeditor.com/ckeditor4/docs/#!/guide/dev_file_upload
//https://ckeditor.com/old//forums/Support/Changing-image-URL-after-Upload
//https://docs.ckeditor.com/ckeditor4/docs/#!/guide/dev_file_browser_api
//https://docs.ckeditor.com/ckeditor4/docs/#!/guide/dev_file_manager_configuration
/*
window.CKEDITOR.on('instanceReady', function () {
    var toolbar = document.getElementsByClassName('cke_top').item(0),
                  boxTop = toolbar.getBoundingClientRect().top,
                  offsetTop = 45; // toolbar offset top

    window.addEventListener('scroll', function () {
        window.requestAnimationFrame(function () {
            var scrollTop =document.body.scrollTop;
            if ((scrollTop + offsetTop) > boxTop) {
                toolbar.style.top = scrollTop + offsetTop - boxTop + 'px';
            } else {
                toolbar.style.top = 0;
            }
        });
    }, false);
});
*/
/*
CKEDITOR.replace( 'editor1', {
    extraPlugins: 'divarea',
    on: {
        instanceReady: function() {
            this.editable().setStyle( 'background-color', 'red' );
        }
    }
} );
.cke_dialog
{
    z-index: 10055 !important;
}

<script type="text/javascript">
    // Include this file AFTER both jQuery and bootstrap are loaded.
    $.fn.modal.Constructor.prototype.enforceFocus = function() {
      modal_this = this
      $(document).on('focusin.modal', function (e) {
        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length 
        && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select') 
        && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_textarea')
        && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
          modal_this.$element.focus()
        }
      })
    };
</script>

image error fixed- put this after bootstrap anj jquery load


<script>
            $.fn.modal.Constructor.prototype.enforceFocus = function () {
                modal_this = this
                $(document).on('focusin.modal', function (e) {
                    if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
                    && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select')
                    && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
                        modal_this.$element.focus()
                    }
                })
            };
        </script>
*/
//https://sdk.ckeditor.com/samples/autogrow.html

//create own plugins
//https://docs-old.ckeditor.com/CKEditor_3.x/Tutorials/Timestamp_Plugin
//https://docs.ckeditor.com/ckeditor4/docs/#!/guide/plugin_sdk_intro
//https://docs-old.ckeditor.com/CKEditor_3.x/Tutorials/Timestamp_Plugin
//https://stackoverflow.com/questions/7676144/ckeditor-format-class