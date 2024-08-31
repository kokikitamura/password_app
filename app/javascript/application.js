// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery

// $(function() {
//   $('#js-copybtn').on('click', function(){
//     // コピーする文章の取得
//     let text = $('#js-copytext').text();
//     // テキストエリアの作成
//     let $textarea = $('<textarea></textarea>');
//     // テキストエリアに文章を挿入
//     $textarea.text(text);
//     // テキストエリアを挿入
//     $(this).append($textarea);
//     // テキストエリアを選択
//     $textarea.select();
//     // コピー
//     document.execCommand('copy');
//     // テキストエリアの削除
//     $textarea.remove();
//     alert('「'+text+'」をコピーしました');
//   });
// });

// $(function() {
// 	$('.copy_btn').on('click', function(){
// 		let text = $('.copy_txt').text();
// 		let textarea = $('<textarea></textarea>');
// 		textarea.text(text);
// 		$(this).append(textarea);
// 		textarea.select();
// 		document.execCommand('copy');
// 		textarea.remove();
// 		alert('「'+text+'」をコピーしました');
// 	});
// });


//パスワードジェネレーター
document.addEventListener("turbo:load", function() {
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

  $("#generate_password_button").click(function() {
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
});



document.addEventListener("turbo:render", function() {
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

  $("#generate_password_button").click(function() {
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
});

//パスワードのコピーボタン
$(document).on('click', '#pass-copy', function(){
  // コピーする文章の取得
  let text = $("#pass").text();
  // Copyの文字を変更
  $("#pass-copy").text("コピー済");

  if (navigator.clipboard == undefined) {
      window.clipboardData.setData("Text", text);
  } else {
      navigator.clipboard.writeText(text);
  }
});

//アカウント名のコピーボタン
$(document).on('click', '#account-copy', function(){
  let text = $("#account").text();
  $("#account-copy").text("コピー済");

  if (navigator.clipboard == undefined) {
      window.clipboardData.setData("Text", text);
  } else {
      navigator.clipboard.writeText(text);
  }
});
