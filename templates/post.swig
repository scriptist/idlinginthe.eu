{% extends '_layout.swig' %}

{% block title %}{{post.title}}{% endblock %}
{% block content %}
	<div class="post">
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

			{% elseif line|lineType == 'image' %}

				<div class="post__image">
					{% if line.source %}
						<img src="{{line.source}}" alt="{{line.alt}}">
					{% else %}
						<img src="{{line}}" alt="">
					{% endif %}
				</div>

			{% elseif line|lineType == 'video' %}

				<div class="post__video">
					<video controls>
						<source src="{{line.source}}" />
					</video>
					<button class="post__video__play">Play</button>
				</div>

			{% elseif line|lineType == 'paragraph' %}

				{% set prev = post.content[loop.index0 - 1] %}
				{% set next = post.content[loop.index0 + 1] %}
				{% if !prev || prev|lineType != 'paragraph' || prev.author != line.author %}
					<div class="post__text" data-author="{{line.author}}">
				{% endif %}

					{% for text in line.text %}
						<p>{{text|safe}}</p>
					{% endfor %}

				{% if !next || next|lineType != 'paragraph' || next.author != line.author %}
					</div>
				{% endif %}

			{% else %}

				<p>Template error: unknown line format: {{line|lineType}}</p>
				<code>{{line|json(4)}}</code>

			{% endif %}
		{% endfor %}
	</div>
{% endblock %}