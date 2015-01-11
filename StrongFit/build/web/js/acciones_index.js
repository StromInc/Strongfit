/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function() {
    if (window.matchMedia('(max-width: 768px)').matches){
       var $buttonShow = document.getElementById('show');
       var $buttonHide = document.getElementById('hide');
       var $menu = document.getElementById('formu');

       function showMenu(e) {
          // body...
          e.preventDefault();
          $menu.classList.add('is-active');
          $buttonHide.classList.add('is-active');
          $buttonShow.classList.remove('is-active');
       }
       function hideMenu(e) {
          // body...
          e.preventDefault();
          $buttonShow.classList.add('is-active');
          $menu.classList.remove('is-active');
          $buttonHide.classList.remove('is-active');
       }
       $buttonShow.addEventListener('click', showMenu);
       $buttonHide.addEventListener('click', hideMenu);
    }
});

