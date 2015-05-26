<h1>{{ post.title }}</h1>
{% for line in post.content %}
	{% if line|lineType == 'location' %}

		<h2>{{line}}</h2>

	{% elseif line|lineType == 'date' %}

		<h3>
			<time datetime="{{line|date('Y-m-d')}}">
				<span class="date">{{line|date('d')}}</span>
				<span class="month">{{line|date('M')}}</span>
			</time>
		</h3>

	{% elseif line|lineType == 'paragraph' %}

		{% set prev = post.content[loop.index0 - 1] %}
		{% set next = post.content[loop.index0 + 1] %}
		{% if !prev || prev|lineType != 'paragraph' || prev.author != line.author %}
			<div class="author" data-author="{{line.author}}">
		{% endif %}

				<p>{{line.text}}</p>

		{% if !next || next|lineType != 'paragraph' || next.author != line.author %}
			</div>
		{% endif %}

	{% else %}

		<p>Template error: unknown line format</p>
		<code>{{line|json(4)}}</code>

	{% endif %}
{% endfor %}