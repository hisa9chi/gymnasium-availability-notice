module Pages
  class Page

    # 要素表示待ち時間 10 秒
    waiteTimeout = 10 * 1000

    def initialize( driver, wait )
      @driver = driver
      @wait = wait
    end

    def find_element_by_id( id )
      @wait.until { @driver.find_element( :id, id ) }
    end

    def find_elements_by_id( id )
      @wait.until { @driver.find_elements( :id, id ) }
    end

    def find_element_by_class( class_name )
      @wait.until { @driver.find_element( :class, class_name ) }
    end

    def find_elements_by_class( class_name )
      @wait.until { @driver.find_elements( :class, class_name ) }
    end

    def find_element_by_xpath( xpath )
      @wait.until { @driver.find_element( :xpath, xpath ) }
    end

    def find_elements_by_xpath( xpath )
      @wait.until { @driver.find_elements( :xpath, xpath ) }
    end

    def find_element_by_partial_link_text( text )
      @wait.until { @driver.find_element( :partial_link_text, text ) }
    end

    def find_elements_by_partial_link_text( text )
      @wait.until { @driver.find_elements( :partial_link_text, text ) }
    end

    def find_element_by_link( link )
      @wait.until { @driver.find_element( :link, link ) }
    end
    
    def find_elements_by_link( link )
      @wait.until { @driver.find_elements( :link, link ) }
    end
    
  end # Page
end # Pages
