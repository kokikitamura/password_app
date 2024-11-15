// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery

//パスワードジェネレーター
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


//ハンバーガーメニュー
document.addEventListener("turbo:load", setupHamburgerMenu);
document.addEventListener("turbo:render", setupHamburgerMenu);

function setupHamburgerMenu() {
  $('#hamburger-menu, .hamburger-link').off('click').on('click', function () {
    $('.hamburger-nav').slideToggle(200);
    $('.hamburger-menu').toggleClass('hamburger-menu--open');
  });
}


//フィルターオプション
document.addEventListener("turbo:load", setupOption);
document.addEventListener("turbo:render", setupOption);

function setupOption() {
  // スマホの場合のみ
  if ($(window).width() <= 768) {
    $('.option').hide();
    $('#filter-btn').off('click').on('click', function () {
      $('.option').slideToggle();
    });
  }
}
