// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery


document.addEventListener("turbo:load", setupPasswordGenerator);
document.addEventListener("turbo:render", setupPasswordGenerator);

function setupPasswordGenerator() {
  function generatePassword(length, includeCapital, includeNumbers, includeSymbols) {
    let charset = "abcdefghijklmnopqrstuvwxyz";
    if (includeCapital) charset += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if (includeNumbers) charset += "0123456789";
    if (includeSymbols) charset += "!@#$%";

    let password = "";
    for (let i = 0; i < length; i++) {
      password += charset[Math.floor(Math.random() * charset.length)];
    }
    return password;
  }

  $("#generate_password_button").off('click').on('click', function() {
    // 各オプションの値を取得
    const length = $("#password_length").val();
    let includeCapital = $("#include_capital").is(":checked");
    let includeNumbers = $("#include_numbers").is(":checked");
    let includeSymbols = $("#include_symbols").is(":checked");

    // パスワード生成
    const password = generatePassword(length, includeCapital, includeNumbers, includeSymbols);

    // パスワード入力フォームにセット
    $("#password_field").val(password);
  });
}


//パスワードのコピーボタン
$(document).on('click', '#pass-copy', function(){
  // コピーする文章の取得
  let text = $("#pass").text();
  // copyの文字をcopiedに変更
  $("#pass-copy").html("<i class='fa-regular fa-copy' style='color: #ffffff;'></i> copied");

  if (navigator.clipboard == undefined) {
      window.clipboardData.setData("Text", text);
  } else {
      navigator.clipboard.writeText(text);
  }
});

//アカウント名のコピーボタン
$(document).on('click', '#account-copy', function(){
  let text = $("#account").text();
  $("#account-copy").html("<i class='fa-regular fa-copy' style='color: #ffffff;'></i> copied");

  if (navigator.clipboard == undefined) {
      window.clipboardData.setData("Text", text);
  } else {
      navigator.clipboard.writeText(text);
  }
});

//ヘッダーのドロップダウン
//$(document).on('turbolinks:load', function() {
// $(function() {
//   $(".nav").children("li").hover(function(){
//     $(".dropdown-lists").stop().slideToggle(100);
//   });
// });
// });
// $(document).on('turbolinks:load', function() {
//   $(function () {
//     $('#js-hamburger-menu, .hamburger-link').on('click', function () {
//       $('.hamburger-nav').slideToggle(200)
//       $('.hamburger-menu').toggleClass('hamburger-menu--open')
//     });
//   });
// });

// document.addEventListener("turbo:load", function() {
//   $('#js-hamburger-menu, .hamburger-link').on('click', function () {
//     $('.hamburger-nav').slideToggle(200)
//     $('.hamburger-menu').toggleClass('hamburger-menu--open')
//   });
// });

// document.addEventListener("turbo:render", function() {
//   $('#js-hamburger-menu, .hamburger-link').on('click', function () {
//     $('.hamburger-nav').slideToggle(200)
//     $('.hamburger-menu').toggleClass('hamburger-menu--open')
//   });
// });

//ハンバーガーメニュー
document.addEventListener("turbo:load", setupHamburgerMenu);
document.addEventListener("turbo:render", setupHamburgerMenu);

function setupHamburgerMenu() {
  $('#hamburger-menu, .hamburger-link').off('click').on('click', function () {
    $('.hamburger-nav').slideToggle(200);
    $('.hamburger-menu').toggleClass('hamburger-menu--open');
  });
}
