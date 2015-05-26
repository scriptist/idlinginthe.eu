<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="description" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>{% block title_full %}{% block title %}{% endblock %} - Idling in the EU{% endblock %}</title>

		<link href='http://fonts.googleapis.com/css?family=Marcellus+SC|Lora|Raleway:300' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" href="/styles/global.css">

		<link rel="icon" type="image/png" href="/images/favicon.png">
	</head>
	<body>

		{% block content %}{% endblock %}

		{#<script src="/scripts/global.js"></script>#}

		<!-- Google Analytics -->
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
				(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
				m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

			ga('create', 'UA-63401404-1', 'auto');
			ga('send', 'pageview');
		</script>

	</body>
</html>