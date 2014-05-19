$ ->
  gifAnimation = $("#gifAnimation")
  if gifAnimation.length > 0

    gifImage = null
    imgLoaded = false

    imageCount = 1
    srcX = 0
    srcY = 0
    srcW = 0
    srcH = 0
    targetX = 0
    targetY = 0
    targetW = 0
    targetH = 0

    $(window).resize ->
      redraw()

    init= ->
      srcW = parseInt(gifAnimation.data("imgwidth"))
      srcH = parseInt(gifAnimation.data("imgheight"))
      imageCount = parseInt(gifAnimation.data("totalheight")) / srcH

      gifImage = new Image();
      gifImage.src = gifAnimation.data("url")
      gifImage.onload = ->
        imgLoaded = true
        deviceOrientationHandler(0, 0, 0)

      $(window).on 'deviceorientation', (e) ->
        tiltLR = e.gamma
        tiltFB = e.beta
        dir = e.alpha
        deviceOrientationHandler(tiltLR, tiltFB, dir)

      gifAnimation.on 'mousemove', (e) ->
        x = e.pageX - this.offsetLeft
        y = e.pageY - this.offsetTop
        mouseOverHandler(x, y)

      gifAnimation.on 'click', (e) ->
        location.reload()

      setInterval(redraw, 50)
      
    is_landscape = ->
      window.orientation == 90 or window.orientation == -90

    mouseOverHandler = (x, y) ->
      imgIndex = parseInt(x * imageCount / gifAnimation.width())
      computeData(imgIndex)
      redraw()

    deviceOrientationHandler = (tiltLR, tiltFB, dir) ->
      angle = tiltLR 
      if is_landscape()
        angle -= 90

      angleStep = 80.0 / (imageCount-1)

      if angle < -40
        angle = -40;
      else if angle > 40
        angle = 40
      angle += 40

      imgIndex = parseInt(angle / angleStep)
      computeData(imgIndex)

    getHeight = ->
      window.innerHeight

    computeData = (imgIndex) ->
      #srcX = imgIndex * srcW
      srcX = 0
      srcY = imgIndex * srcH

      ratioX = window.innerWidth / srcW
      ratioY = getHeight() / srcH

      ratio = 0
      targetX = 0
      targetY = 0

      if ratioX > ratioY
        ratio = ratioY
      else
        ratio = ratioX

      targetW = srcW * ratio
      targetH = srcH * ratio

      targetX = (window.innerWidth  - targetW) / 2
      targetY = (getHeight() - targetH) / 2

    redraw= ->
      if imgLoaded
        canvas = gifAnimation[0]
        canvas.width = window.innerWidth
        canvas.height = window.innerHeight
        ctx = canvas.getContext("2d")
        ctx.drawImage(gifImage, srcX, srcY, srcW, srcH, targetX, targetY, targetW, targetH)


    init()
