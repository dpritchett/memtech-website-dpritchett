// gonna refactor you to a json data source one day
var pickRandomUserName = function() {
  userLis = $(".userlist li");
  userLi = userLis[Math.floor(Math.random()*userLis.length)];
  return $(userLi).text();
};

// load a random person's page in a big iframe
var loadRandomPage = function() {
  name = pickRandomUserName();
  link = "/~" + name

  // describe it
  $(".randomPage a:first").attr('href', link);
  $(".randomPage a:first").text(name);

  $(".randomPage iframe:first").attr('src', link);
};

$(loadRandomPage);
