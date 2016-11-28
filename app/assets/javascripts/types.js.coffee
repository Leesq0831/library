  $ ->  
    $("[data-validate]").blur ->  
      $this = $(this)  
      $.get($this.data("validate"),  
        name: $this.val()  
      ).success(->  
        $("#type_info").empty()  
        $("#type_info").append ""+"can"  
        return  
      ).error ->  
        $("#type_info").empty()  
        $("#type_info").append ""+"exist"  
        return  
      return  
    return  