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
        , { name: 'clipboard', groups: ['clipboard', 'undo'] } //cut
        , { name: 'colors', groups: ['colors'] }
        , { name: 'basicstyles', groups: ['basicstyles', 'cleanup'] } //bold
		, { name: 'styles', groups: ['styles'] } //font
        
		, { name: 'forms', groups: ['forms'] }
		, { name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] }
        
        , { name: 'editing', groups: ['selection', 'find', 'spellchecker', 'editing'] }
        
		
        
        //, { name: 'links', groups: ['links'] }
        , { name: 'tools', groups: ['tools'] }
		, { name: 'insert', groups: ['insert'] }
		
		, { name: 'links', groups: ['links'] }
		//, { name: 'insert', groups: ['insert'] }
		
		
		//, { name: 'others', groups: ['others'] }
		//, { name: 'about', groups: ['about'] }
    ];

    config.removeButtons = 'Anchor,Subscript,Superscript,PasteFromWord,PasteText,Print,Link,Unlink,Maximize,ShowBlocks,Find,SpellChecker';
    config.filebrowserUploadUrl = "base64";
    config.toolbarCanCollapse = true;
    //config.toolbarLocation = 'bottom';
    config.toolbarStartupExpanded = false;
    //config.uiColor = '#57A581';
    config.uiColor = '#D43F3A';
    config.useComputedState = false;
    config.filebrowserBrowseUrl = '/browser/browse.php';
    config.filebrowserUploadUrl = 'UploadHandler.ashx';
    //config.extraPlugins = 'uploadimage';
    config.extraPlugins = 'filebrowser,uploadimage';
    config.filebrowserWindowWidth = '640';
    config.filebrowserWindowHeight= '480';

    /*
    config.filebrowserBrowseUrl= '/ckfinder/ckfinder.html';
    config.filebrowserImageBrowseUrl= '/ckfinder/ckfinder.html?type=Images';
    config.filebrowserUploadUrl= '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files';
    config.filebrowserImageUploadUrl= '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images'; //*/
    //config.menu_groups = 'clipboard,table,anchor,link,image';
    //config.pasteFromWordRemoveStyles = false;
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