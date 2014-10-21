// mmm, yeah
var fetchActiveUsers = function() {
  $.getJSON('/~dpritchett/data/user_stats.json', parseUserData);
};

// load active users into window.users
var parseUserData = function(data) {
  window.users = _.select(data.users,
      function(u) { return u.active });

  renderUserList();
  displayUserPage(_.sample(users).name);
};

// list all active users in a UL
var renderUserList = function() {
  shuffledUsers = _.shuffle(users);

  _.each(shuffledUsers, function(u){
    name = u.name;
    $(".userlist").append("<li><a href='/~" + name + "'>" + name + "</a></li>");
  });
};

// load a random person's page in a big iframe
var displayUserPage = function(user) {
  name = user;
  link = "/~" + name;

  // describe it
  $(".randomPage a:first").attr('href', link);
  $(".randomPage a:first").text("~" + name);

  $(".randomPage iframe:first").attr('src', link);
//  $(".randomPage").show();
};

var loadRandomUserPage = function() {
  name = _.sample(users).name;
  return displayUserPage(name)
};

// THANKS STACKOVERFLOW GUYS I LOVE IT /a/8620357
var dayOfYear = function() {
  var now    = new Date();
  var start  = new Date(now.getFullYear(), 0, 0);
  var diff   = now - start;
  var oneDay = 1000 * 60 * 60 * 24;
  return Math.ceil(diff / oneDay);
};

var userOfDay = function() {
  index = dayOfYear % window.users.length();
  window.users[index];
};

var startSlideshow = function() {
  loadRandomUserPage();
  setInterval(loadRandomUserPage, 4000);
  $(".randomPage").hide();
}

$(fetchActiveUsers);
