<h1>{{ post.title }}</h1>
{% for line in post.content %}
	<p>{{line}}</p>
{% endfor %}