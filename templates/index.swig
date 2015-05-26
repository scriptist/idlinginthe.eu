{% extends '_layout.swig' %}

{% block title_full %}Idling in the EU{% endblock %}
{% block content %}
	<ul>
		{% for post in posts %}
			<li><a href="/{{post.slug}}">{{post.title}}</a></li>
		{% endfor %}
	</ul>
{% endblock %}