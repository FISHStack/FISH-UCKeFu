(function($){
var snakerflow = $.snakerflow;

$.extend(true, snakerflow.editors, {
	inputEditor : function(){
		var _props,_k,_div,_src,_r;
		this.init = function(props, k, div, src, r){
			_props=props; _k=k; _div=div; _src=src; _r=r;
			
			$('<input style="width:95.2%;height:18px;border-radius: 4px;"/>').val(props[_k].value).change(function(){
				props[_k].value = $(this).val();
			}).appendTo('#'+_div);
			
			$('#'+_div).data('editor', this);
		}
		this.destroy = function(){
			$('#'+_div+' input').each(function(){
				_props[_k].value = $(this).val();
			});
		}
	},
	selUserEditor : function(arg){
		var _props,_k,_div,_src,_r;
		this.init = function(props, k, div, src, r){
			_props=props; _k=k; _div=div; _src=src; _r=r;

			if(typeof arg === 'string'){
				var sle = $('<select  style="width:99%;height:150px;margin-top:5px;margin-bottom:5px;" multiple="multiple"><option value="">所有人</option></select>').change(function(){
					props[_k].value = $(this).val().toString();
				}).appendTo('#'+_div);				
				
				$.ajax({
				   type: "GET",
				   url: allUserListURL,
				   success: function(data){
					  var opts = eval(data);
					 if(opts && opts.length){
						for(var idx=0; idx<opts.length; idx++){
							if(props[_k].value.indexOf(opts[idx].value) >= 0){
								sle.append('<option value="'+opts[idx].value+'" selected="selected">'+opts[idx].name+'</option>');
							}else{
								sle.append('<option value="'+opts[idx].value+'">'+opts[idx].name+'</option>');							
							}
						}
					 }
				   }
				});
			}else {
				var sle = $('<select  style="width:100%;"><option value="">所有人</option></select>').val(props[_k].value).change(function(){
					props[_k].value = $(this).val().toString();
				}).appendTo('#'+_div);

				for(var idx=0; idx<arg.length; idx++){
					sle.append('<option value="'+arg[idx].value+'">'+arg[idx].name+'</option>');
				}
				sle.val(_props[_k].value);
			}
			
			$('#'+_div).data('editor', this);
		};
		this.destroy = function(){
			$('#'+_div+' input').each(function(){
				_props[_k].value = $(this).val();
			});
		};
	},
	selTimeEditor : function(){
		var _props,_k,_div,_src,_r;
		this.init = function(props, k, div, src, r){
			_props=props; _k=k; _div=div; _src=src; _r=r;
			
			$('<input style="width:98%;" class="Wdate" onClick=\'WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss"})\'/>').val(props[_k].value).change(function(){
				props[_k].value = $(this).val();
			}).appendTo('#'+_div);
			
			$('#'+_div).data('editor', this);
		}
		this.destroy = function(){
			$('#'+_div+' input').each(function(){
				_props[_k].value = $(this).val();
			});
		}
	},
	selectEditor : function(arg){
		var _props,_k,_div,_src,_r;
		this.init = function(props, k, div, src, r){
			_props=props; _k=k; _div=div; _src=src; _r=r;

			if(typeof arg === 'string'){
				var node = "";
				var ids = props[_k].value.split(",");
				var secmenu = "" ;
				if(ids.length == 2){
					secmenu = ids[0] ;	
					node = ids[1] ;
				}
				var sle = $('<select  style="width:47%;"></select>').val(props[_k].value).change(function(){
					node = $(this).val();
					dic.empty();
					$.ajax({
					   type: "GET",
					   url: allFormListURL+"?sid="+node,
					   success: function(data){
						  var opts = eval(data);
						 if(opts && opts.length){
							for(var idx=0; idx<opts.length; idx++){
								if(node == ""){
									node = opts[idx].value ;
								}
								if(secmenu!="" && secmenu == opts[idx].value) {
									dic.append('<option value="'+opts[idx].value+'" selected="selected">'+opts[idx].name+'</option>');
								}else{
									dic.append('<option value="'+opts[idx].value+'">'+opts[idx].name+'</option>');								
								}
							}
							dic.val(_props[_k].value);
						 }
					   }
					});
					props[_k].value = $(sle).val() + "," +$(dic).val();
				}).appendTo('#'+_div);				
				
				var dic = $('<select  style="width:50%;margin-left:5px;"><option value="">--无--</option></select>').val(props[_k].value).change(function(){
					props[_k].value = sle.val() + "," +$(dic).val();
				}).appendTo('#'+_div);
				
				
				$.ajax({
				   type: "GET",
				   url: allSecmenuListURL,
				   success: function(data){
					  var opts = eval(data);
					 if(opts && opts.length){
						for(var idx=0; idx<opts.length; idx++){
							if(secmenu == ""){
								secmenu = opts[idx].value ;
							}
							if(secmenu == opts[idx].value){
								sle.append('<option value="'+opts[idx].value+'" selected="selected">'+opts[idx].name+'</option>');
							}else{
								sle.append('<option value="'+opts[idx].value+'">'+opts[idx].name+'</option>');							
							}
						}
						sle.val(secmenu);
					 }
				   }
				});

				$.ajax({
				   type: "GET",
				   url: allFormListURL+"?sid="+secmenu,
				   success: function(data){
					  var opts = eval(data);
					 if(opts && opts.length){
						for(var idx=0; idx<opts.length; idx++){
							if(node == ""){
								node = opts[idx].value ;
							}
							if(node == opts[idx].value){
								dic.append('<option value="'+opts[idx].value+'" selected="selected">'+opts[idx].name+'</option>');
							}else{
								dic.append('<option value="'+opts[idx].value+'">'+opts[idx].name+'</option>');
							}
						}
						dic.val(node);
					 }
				   }
				});
			}else {
				var sle = $('<select  style="width:99%;"/>').val(props[_k].value).change(function(){
					props[_k].value = $(this).val();
				}).appendTo('#'+_div);

				for(var idx=0; idx<arg.length; idx++){
					sle.append('<option value="'+arg[idx].value+'">'+arg[idx].name+'</option>');
				}
				sle.val(_props[_k].value);
			}
			
			$('#'+_div).data('editor', this);
		};
		this.destroy = function(){
			$('#'+_div+' input').each(function(){
				_props[_k].value = $(this).val();
			});
		};
	}
});

})(jQuery);