/*
 Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function(config) {
    config.language = 'es';
    config.uiColor = '#AABBCC';

    config.height = '180px';

    config.toolbar = 'Min';

    config.toolbar_Min =
        [
            { name: 'basicstyles', items : [ 'Bold','Italic','Underline','-','Subscript','Superscript','-','RemoveFormat' ] },
            { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent',
                '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
            { name: 'styles', items : [ 'Format','Font','FontSize' ] },
            { name: 'colors', items : [ 'TextColor','BGColor' ] },
            { name: 'insert', items : [ 'Table', 'SpecialChar' ] },
            { name: 'about', items : [ 'About' ] }
        ];
};
