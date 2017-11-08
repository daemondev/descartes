CKEDITOR.editorConfig = function (config) {
    config.toolbarGroups = [
		{ name: 'document', groups: ['selection', 'clipboard', 'mode', 'document', 'doctools' ] }
		//, { name: 'clipboard', groups: ['clipboard', 'undo'] }
		, { name: 'forms', groups: ['forms'] }
		, { name: 'colors', groups: ['colors'] }
		, { name: 'basicstyles', groups: ['basicstyles', 'cleanup'] }
        //, { name: 'links', groups: ['links'] }
        , { name: 'tools', groups: ['tools'] }
		//, { name: 'insert', groups: ['insert'] }
		, { name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] }
		, { name: 'links', groups: ['links'] }
		, { name: 'insert', groups: ['insert'] }
		, { name: 'editing', groups: ['selection', 'find', 'spellchecker', 'editing'] }
		, { name: 'styles', groups: ['styles'] }
		//, { name: 'others', groups: ['others'] }
		//, { name: 'about', groups: ['about'] }
    ];

    config.removeButtons = 'Anchor,Subscript,Superscript,PasteFromWord,PasteText,Print,Link,Unlink,Maximize,ShowBlocks,Find,SpellChecker,Save,NewPage,Cut,Templates,Paste';
    //config.removeButtons = 'Cut,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript,Maximize,ShowBlocks,BGColor,TextColor,Font,FontSize,Emojione,PageBreak,Smiley,Link,Unlink,JustifyRight,JustifyCenter,Outdent,Indent,BulletedList,NumberedList,CopyFormatting,RemoveFormat,Italic,Bold,Find,Replace,PasteText,PasteFromWord,Templates,Save,NewPage';
    config.filebrowserUploadUrl = "base64";
    config.toolbarCanCollapse = true;
    //config.toolbarLocation = 'bottom';
    //class:cke_toolbar
    config.toolbarStartupExpanded = false;
    //config.uiColor = '#57A581';
    config.uiColor = '#D9EBE2';
    //config.uiColor = '#D43F3A';
    //config.readOnly = true;
    config.bodyId = 'contents_id';
    config.bodyClass = 'contents';
    config.useComputedState = false;
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
//https://docs-old.ckeditor.com/CKEditor_3.x/Developers_Guide/Toolbar
////config = { toolbar: [['SelectAll', 'Copy', 'Styles']] };