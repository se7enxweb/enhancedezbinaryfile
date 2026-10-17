/**
 * enhancedezbinaryfile: "Select all" of the debug node view (node/view/debug_form.tpl).
 *
 * The button (data-enhancedezbinaryfile-check-all) ticks every remove box (DeleteIDArray[]) of its form and turns into
 * "Deselect all" (data-deselect-all), which clears them again (data-select-all), as the inline checkAll() did before.
 * One listener on the document, so the page needs no inline script or handler (Content Security Policy without
 * 'unsafe-inline').
 */
(function () {
    if ( window.enhancedEzBinaryFileDebugFormReady ) { return; }
    window.enhancedEzBinaryFileDebugFormReady = true;
    document.addEventListener( 'click', function ( e ) {
        var button = e.target;
        if ( !button || !button.hasAttribute || !button.hasAttribute( 'data-enhancedezbinaryfile-check-all' ) || !button.form ) { return; }
        var select = button.value === button.getAttribute( 'data-select-all' );
        button.value = button.getAttribute( select ? 'data-deselect-all' : 'data-select-all' );
        Array.prototype.forEach.call( button.form.elements, function ( element ) {
            if ( element.type === 'checkbox' && element.name === 'DeleteIDArray[]' ) { element.checked = select; }
        } );
    } );
})();
