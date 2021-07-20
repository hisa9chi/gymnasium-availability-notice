module Pages
  class Page

    # 要素表示待ち時間 10 秒
    waiteTimeout = 10 * 1000

    def initialize( driver, wait )
      @driver = driver
      @wait = wait
    end

    def findElementById(id)
      @wait.until { @driver.find_element(:id, id) }
    end

    def findElementsById(id)
      @wait.until { @driver.find_elements(:id, id) }
    end

    def findElementByClass(class_name)
      @wait.until { @driver.find_element(:class, class_name ) }
    end

    def findElementsByClass(class_name)
      @wait.until { @driver.find_elements(:class, class_name ) }
    end

    def findElementByXpath(xpath)
      @wait.until { @driver.find_element(:xpath, xpath) }
    end

    def findElementsByXpath(xpath)
      @wait.until { @driver.find_elements(:xpath, xpath) }
    end

    def findElementByPartialLinkText(text)
      @wait.until { @driver.find_element(:partial_link_text, text) }
    end

    def findElementsByPartialLinkText(text)
      @wait.until { @driver.find_elements(:partial_link_text, text) }
    end

    def findElementByLink(link)
      @wait.until { @driver.find_element(:link, link) }
    end
    
    def findElementsByLink(link)
      @wait.until { @driver.find_elements(:link, link) }
    end
    
  end # Page
end # Pages
