
function check_if_user_liked(){
  $.get('http://localhost:3000/get_likes/'+ data_get_id + '.json',function(data,status) {
    data_parse = JSON.parse(data);
    awarded = data_parse.awarded;
    if (awarded == 1){
      console.log('awarded');
    }else{
      console.log('not awarded');
    }
  },'html');
}
var data_parse;
function facebookWindow(element,url) {
  var facebook_Window = window.open(url,"facebook_Window","width=800,height=400,scrollbars=no");
  console.log('window opened')
  $.get('http://localhost:3000/set_likes/<%= @product.id %>.json',function(data,status) {
    console.log(data);
    data_parse = JSON.parse(data);
    data_get_id = data_parse['id']
    console.log("Data ID: " + data_get_id)
    check_if_closed();
  },'html');


  console.log('Ajax ran');

  console.log("Facebook window is opened: " + facebook_Window.closed);
  counter = 0;

  function check_if_closed() {
    setTimeout(function(){
      console.log('in check if closed');
      if(facebook_Window.closed){
        console.log('Closed via user');
        clearTimeout(automated_close); clearTimeout(check_if_closed); //Stop timing
        console.log('Closed out check and automated');
        check_if_user_liked(data_get_id);
      }else{
        if(counter = 0){
          automated_close();
        }
        check_if_closed();
      }
    }, 1000);
  }

  function automated_close() {
    setTimeout(function(){
      if(!facebook_Window.closed){
        window.open('', '_self', ''); facebook_Window.close(); //Both for closing the window
        console.log('Closed via code');
        clearTimeout(automated_close); clearTimeout(check_if_closed); //Stop timing
      }
    }, 15000);
  }
}
var data_parse;
function instagramWindow(element,url) {
  var instagram_Window = window.open(url,"instagram_Window","width=800,height=400,scrollbars=no");
  console.log('window opened')
  $.get('http://localhost:3000/set_instagram/<%= @product.id %>.json',function(data,status) {
    console.log(data);
    data_parse = JSON.parse(data);
    data_get_id = data_parse['id']
    console.log("Data ID: " + data_get_id)
    insta_check_if_closed();
  },'html');


  console.log('Ajax ran');

  console.log("instagram window is opened: " + instagram_Window.closed);
  counter = 0;

  function insta_check_if_closed() {
    setTimeout(function(){
      console.log('in check if closed');
      if(instagram_Window.closed){
        console.log('Closed via user');
        clearTimeout(insta_automated_close); clearTimeout(insta_check_if_closed); //Stop timing
        console.log('Closed out check and automated');
        insta_check_if_user_liked(data_get_id);
      }else{
        if(counter = 0){
          insta_automated_close();
        }
        insta_check_if_closed();
      }
    }, 1000);
  }

  function insta_automated_close() {
    setTimeout(function(){
      if(!instagram_Window.closed){
        window.open('', '_self', ''); instagram_Window.close(); //Both for closing the window
        console.log('Closed via code');
        clearTimeout(insta_automated_close); clearTimeout(insta_check_if_closed); //Stop timing
      }
    }, 15000);
  }
  function insta_check_if_user_liked(){
    $.get('http://localhost:3000/get_instagram/'+ data_get_id + '.json',function(data,status) {
      data_parse = JSON.parse(data);
      awarded = data_parse.awarded;
      if (awarded == 1){
        console.log('awarded');
      }else{
        console.log('not awarded');
      }
    },'html');
  }
}
var data_parse;
function twitterWindow(element,url) {
  var twitter_Window = window.open(url,"twitter_Window","width=800,height=400,scrollbars=no");
  console.log('window opened')
  $.get('http://localhost:3000/set_twitter/<%= @product.id %>.json',function(data,status) {
    console.log(data);
    data_parse = JSON.parse(data);
    data_get_id = data_parse['id']
    console.log("Data ID: " + data_get_id)
    twitter_check_if_closed();
  },'html');


  console.log('Ajax ran');

  console.log("twitter window is opened: " + twitter_Window.closed);
  counter = 0;

  function twitter_check_if_closed() {
    setTimeout(function(){
      console.log('in check if closed');
      if(twitter_Window.closed){
        console.log('Closed via user');
        clearTimeout(twitter_automated_close); clearTimeout(twitter_check_if_closed); //Stop timing
        console.log('Closed out check and automated');
        twitter_check_if_user_liked(data_get_id);
      }else{
        if(counter = 0){
          twitter_automated_close();
        }
        twitter_check_if_closed();
      }
    }, 1000);
  }

  function twitter_automated_close() {
    setTimeout(function(){
      if(!twitter_Window.closed){
        window.open('', '_self', ''); twitter_Window.close(); //Both for closing the window
        console.log('Closed via code');
        clearTimeout(twitter_automated_close); clearTimeout(twitter_check_if_closed); //Stop timing
      }
    }, 15000);
  }
  function twitter_check_if_user_liked(){
    $.get('http://localhost:3000/get_twitter/'+ data_get_id + '.json',function(data,status) {
      data_parse = JSON.parse(data);
      awarded = data_parse.awarded;
      if (awarded == 1){
        console.log('awarded');
      }else{
        console.log('not awarded');
      }
    },'html');
  }
}
