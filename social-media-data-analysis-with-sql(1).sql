/* Social Media Data Analysis Project using SQL */


/* #1. We want to reward the user who has been around the longest, Find the 5 oldest users. */ 
   use ig_clone;
   SELECT username FROM users ORDER BY created_at ASC LIMIT 5;

/* #2. To understand when to run the ad campaign, figure out the day of the week most users register on? */
   SELECT sum(id) as max_user, dayname(created_at) FROM users GROUP BY username order by max_user desc limit 1;

/* #3. To target inactive users in an email ad campaign, find the users who have never posted a photo. */
   select username from users where username not in (select username from photos inner join users on photos.user_id = users.id);

/* #4.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? */
   select count(photo_id) as onenum, user_id, username from likes inner join users on likes.user_id=users.id
   group by user_id order by onenum desc;


/* #5. The investors want to know how many times does the average user post. */
   select Floor(avg(total_post)) from (select user_id, count(image_url) as total_post from photos group by user_id)as image;

/* #6.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags. */
   select tag_name from tags
   inner join photo_tags on photo_tags.tag_id = tags.id group by tag_id 
   order by tag_id desc limit 5;

/* #7.To find out if there are bots, find users who have liked every single photo on the site. */
   select l.user_id, username from likes l inner join users u on l.user_id=u.id group by user_id having count(photo_id) in
   (select count(id) from photos);

/* #8. To know who the celebrities are, find users who have never commented on a photo. */ 
   select id,username from users where id not in (select user_id from comments);
    
/* #9 Now it's time to find both of them together, find the users who have never commented on any photo or has commented on every photo. */
   select id, username from users where id not in (select user_id from comments) 
   union
   select c.user_id, username from comments c inner join users u on c.user_id=u.id group by user_id having count(photo_id)
   in (select count(id) from photos);

