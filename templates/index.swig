{% extends '_layout.swig' %}

{% block title_full %}Idling in the EU{% endblock %}
{% block content %}

	<div class="home">
		<header class="header">
			<h1>Idling in the EU</h1>
		</header>

		<nav class="nav">
			{% for post in posts %}
				<a href="/{{post.slug}}">{{post.title}}</a>
			{% endfor %}
		</nav>
	</div>


{% endblock %}