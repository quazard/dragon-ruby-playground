module CollisionUtility

  TOP_RECT_KEY = :top
  BOTTOM_RECT_KEY = :bottom
  LEFT_RIGHT_RECT_KEY = :left_right

  INTERSECT_OFFSET = 0.1
  COLLISION_TOLLERANCE = 0.0


  def collision_edge!(element, width, height)
    # vertical axis
    if element.y < 0
      element.y = 0
    elsif element.y > height - element.h
      element.y = height - element.h
    end

    # horizontal axis
    if element.x >= width - element.w
      element.x = width - element.w
    elsif element.x <= 0
      element.x = 0
    end
  end

  def calculate_collision(element, collision_rects)
    collision_bottom!(element, collision_rects)
    collision_left!(element, collision_rects)
    collision_right!(element, collision_rects)
    collision_top!(element, collision_rects)
  end

  def collision_bottom!(element, collision_rects)
    element_rect = [element.x, element.y - INTERSECT_OFFSET, element.w, element.h]

    collision = collision_rects
                  .find_all { |r| r[TOP_RECT_KEY].intersect_rect?(element_rect, COLLISION_TOLLERANCE) }
                  .first
    
    return unless collision

    element.y = collision[TOP_RECT_KEY].top
  end

  def collision_left!(element, collision_rects)
    element_rect = [element.x - INTERSECT_OFFSET, element.y, element.w, element.h]
    
    collision = collision_rects
                  .find_all { |r| r[LEFT_RIGHT_RECT_KEY].intersect_rect?(element_rect, COLLISION_TOLLERANCE) }
                  .first
    
    return unless collision

    element.y = collision[LEFT_RIGHT_RECT_KEY].right
  end

  def collision_right!(element, collision_rects)
    element_rect = [element.x + INTERSECT_OFFSET, element.y, element.w, element.h]

    collision = collision_rects
                  .find_all { |r| r[LEFT_RIGHT_RECT_KEY].intersect_rect?(element_rect, COLLISION_TOLLERANCE) }
                  .first
    
    return unless collision

    element.y = collision[LEFT_RIGHT_RECT_KEY].left - element.w
  end

  def collision_top!(element, collision_rects)
    element_rect = [element.x, element.y + INTERSECT_OFFSET, element.w, element.h]

    collision = collision_rects
                  .find_all { |r| r[BOTTOM_RECT_KEY].intersect_rect?(element_rect, COLLISION_TOLLERANCE) }
                  .first
    
    return unless collision

    element.y = collision[BOTTOM_RECT_KEY].y - element.y
  end

end
