CKEDITOR.editorConfig = function (config) {
    config.toolbarGroups = [
        { name: 'document', groups: ['selection', 'clipboard', 'mode' ] }
        //, { name: 'document', groups: ['selection', 'clipboard', 'mode', 'document', 'doctools'] }
		//, { name: 'clipboard', groups: ['clipboard', 'undo'] }
		, { name: 'forms', groups: ['forms'] }
		, { name: 'colors', groups: ['colors'] }
		, { name: 'basicstyles', groups: ['basicstyles', 'cleanup'] }        
        , { name: 'tools', groups: ['tools'] }		
		, { name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] }
		, { name: 'links', groups: ['links'] }
		, { name: 'insert', groups: ['insert'] }
		, { name: 'editing', groups: ['selection', 'find', 'spellchecker', 'editing'] }
		, { name: 'styles', groups: ['styles'] }
		//, { name: 'others', groups: ['others'] }
		//, { name: 'about', groups: ['about'] }
    ];

    //config.removeButtons = 'Anchor,Subscript,Superscript,PasteFromWord,PasteText,Print,Link,Unlink,Maximize,ShowBlocks,Find,SpellChecker,Save,NewPage,Cut,Templates,Paste'; config.removeButtons = 'Anchor,Subscript,Superscript,PasteFromWord,PasteText,Print,ShowBlocks,Find,SpellChecker'; //Link,Unlink,
    config.removeButtons = 'Anchor,Subscript,Superscript,PasteFromWord,PasteText,Print,ShowBlocks,Find,SpellChecker,Templates,Save,NewPage,Cut,Paste'; //Link,Unlink,
    //config.removeButtons = 'Cut,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript,Maximize,ShowBlocks,BGColor,TextColor,Font,FontSize,Emojione,PageBreak,Smiley,Link,Unlink,JustifyRight,JustifyCenter,Outdent,Indent,BulletedList,NumberedList,CopyFormatting,RemoveFormat,Italic,Bold,Find,Replace,PasteText,PasteFromWord,Templates,Save,NewPage';
    config.extraPlugins = 'filebrowser,uploadimage,div,table,tabletools,tableresize,autogrow,html5video';
    config.filebrowserUploadUrl = "base64";
    config.toolbarCanCollapse = true;
    //config.toolbarLocation = 'bottom';
    //class:cke_toolbar
    config.toolbarStartupExpanded = false;
    //config.uiColor = '#57A581';
    //config.uiColor = '#D9EBE2'; //cyan
    //config.uiColor = '#D43F3A';
    config.uiColor = '#F9E8E8';
    

    //config.autoGrow_minHeight = 200;
    //config.autoGrow_maxHeight = 430;
    //config.autoGrow_bottomSpace = 50;
    config.autoGrow_onStartup = true;
    //config.bodyId = 'contents_id';
    //config.bodyClass = 'contents';
    //config.useComputedState = false;
    //config.menu_groups = 'clipboard,table,anchor,link,image';
    //config.pasteFromWordRemoveStyles = false;
    /*
    config.templates_files =
    [
        '/templates/site_default.js',
        'http://localhost/templates.js'
    ];
    config.templates = 'my_templates'; //*/
    config.readOnly = true;
};  //*/
//https://docs-old.ckeditor.com/CKEditor_3.x/Developers_Guide/Toolbar
////config = { toolbar: [['SelectAll', 'Copy', 'Styles']] };
//https://stackoverflow.com/questions/20484492/ckeditor-how-to-enable-custom-plugin-button-when-in-source-mode