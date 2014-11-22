var _rys = jQuery.noConflict();

_rys("document").ready(function(){
    var win = _rys(window).height();
    _rys(".content-contador").height(_rys('.Article-menu').height() - 113);
    function barra()
    {
        var al = _rys('.Article-menu').height();
        var al_platillos = al - 113;
        _rys(window).scroll(function () {
            if (_rys(this).height() + _rys(this).scrollTop() === _rys(document).height()) {
                var altura = _rys('.Article-menu').height() - 80;
                _rys('.Article-menu').height(altura);
                _rys('.content-contador').height(altura - 113);
            }
            else
            {
                _rys('.Article-menu').height(al);
                _rys('.content-contador').height(al_platillos);
            }
        });
    }
    
    function reload()
    {
        location.reload();
    }
    
    window.addEventListener("resize", reload);
    
    barra();
});
