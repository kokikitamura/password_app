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