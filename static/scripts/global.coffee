# Video play buttons

togglePlay = (video) ->
	if video.paused
		video.play()
	else
		video.pause()

checkVideo = (video, parent) ->
	if video.paused
		parent.classList.add 'is-paused'
	else
		parent.classList.remove 'is-paused'


for elm in document.querySelectorAll '.post__video'
	button = elm.querySelector '.post__video__play'
	video = elm.querySelector 'video'

	do (elm, button, video) ->
		if video
			checkVideo video, elm

			video.addEventListener 'play', ->
				checkVideo video, elm
			video.addEventListener 'pause', ->
				checkVideo video, elm
			video.addEventListener 'ended', ->
				checkVideo video, elm
			video.addEventListener 'click', ->
				togglePlay video

			if button
				button.addEventListener 'click', ->
					togglePlay video
