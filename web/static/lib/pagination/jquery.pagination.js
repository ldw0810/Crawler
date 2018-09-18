/**
 * This jQuery plugin displays pagination links inside the selected elements.
 *
 * @author Gabriel Birke (birke *at* d-scribe *dot* de)
 * @version 1.2
 * @param {int} maxentries Number of entries to paginate
 * @param {Object} opts Several options (see README for documentation)
 * @return {Object} jQuery Object
 */
jQuery.fn.pagination = function(maxentries, opts){
	opts = jQuery.extend({
		items_per_page:50,
		num_display_entries:10,
		current_page:0,
		num_edge_entries:0,
		link_to:"#",
		first_text:"首页",
		prev_text:"上一页",
		next_text:"下一页",
		last_text:"尾页",
		ellipse_text:"...",
		prev_show_always:true,
		next_show_always:true,
		callback:result//(current_page, items_per_page,this)
		// callback:function(){return false;}
	},opts||{});
	
	return this.each(function() {
		/**
		 * 计算最大分页显示数目
		 */
		function numPages() {
			maxPage = Math.ceil(maxentries/opts.items_per_page);
			return Math.ceil(maxentries/opts.items_per_page);
		}	
		/**
		 * 极端分页的起始和结束点，这取决于current_page 和 num_display_entries.
		 * @返回 {数组(Array)}
		 */
		function getInterval()  {
			var ne_half = Math.ceil(opts.num_display_entries/2);
			var np = numPages();
			var upper_limit = np-opts.num_display_entries;
			var start = current_page>ne_half?Math.max(Math.min(current_page-ne_half, upper_limit), 0):0;
			var end = current_page>ne_half?Math.min(current_page+ne_half, np):Math.min(opts.num_display_entries, np);
			return [start,end];
		}
		// function getInputval()  {
		// 	// var  goPage = jQuery("input").val();
		// 	opts.current_page = $("goToPage").val();
		// 	page_id  = opts.current_page;
		// 	getClickHandler(page_id);
		// }
		
		/**
		 * 分页链接事件处理函数
		 * @参数 {int} page_id 为新页码
		 */
		function pageSelected(page_id, evt){
			current_page = page_id;
			drawLinks();
			var continuePropagation = opts.callback(page_id, items_per_page,maxPage,panel);
			if (!continuePropagation) {
				if(evt) {
					if (evt.stopPropagation) {
						evt.stopPropagation();
					} else {
						evt.cancelBubble = true;
					}
				}
			}
			return continuePropagation;
		}


		
		/**
		 * 此函数将分页链接插入到容器元素中
		 */
		function drawLinks() {
			panel.empty();
			var interval = getInterval();
			var np = numPages();
			if(opts.items_per_page != items_per_page && items_per_page){
				$('#pageNum').val(items_per_page);
				opts.items_per_page = items_per_page;
			}else{
				$('#pageNum').val(opts.items_per_page);
			}
			var inputGoToNewPage = function (val, evt){
				if(+val && +val >= 1 && +val <= numPages()) {
					current_page = val;
					pageSelected(+val - 1, evt)
				} else {
					// alert("input error")
				}
				$("#goToPage").val(val);
			}
			// 这个辅助函数返回一个处理函数调用有着正确page_id的pageSelected。
			var getClickHandler = function(page_id) {
				return function(evt){
					return pageSelected(page_id,evt);
				}
			}
			//辅助函数用来产生一个单链接(如果不是当前页则产生span标签)
			var appendItem = function(page_id, appendopts){
				page_id = page_id<0?0:(page_id<np?page_id:np-1); // 规范page id值
				appendopts = jQuery.extend({text:page_id+1, classes:""}, appendopts||{});
				if(page_id == current_page){
					var lnk = jQuery("<span class='current'>"+(appendopts.text)+"</span>");
				}else{
					var lnk = jQuery("<a>"+(appendopts.text)+"</a>")
						.bind("click", getClickHandler(page_id))
						.attr('href', opts.link_to.replace(/__id__/,page_id));		
				}
				if(appendopts.classes){lnk.addClass(appendopts.classes);}
				panel.append(lnk);
			}
			if(opts.first_text && (current_page > 0 || opts.prev_show_always)){
				appendItem( 0,{text:opts.first_text, classes:"prev"});
			}
			// 产生"Previous"-链接
			if(opts.prev_text && (current_page > 0 || opts.prev_show_always)){
				appendItem(current_page-1,{text:opts.prev_text, classes:"prev"});
			}
			// 产生起始点
			if (interval[0] > 0 && opts.num_edge_entries > 0)
			{
				var end = Math.min(opts.num_edge_entries, interval[0]);
				for(var i=0; i<end; i++) {
					appendItem(i);
				}
				if(opts.num_edge_entries < interval[0] && opts.ellipse_text)
				{
					jQuery("<span>"+opts.ellipse_text+"</span>").appendTo(panel);
				}
			}
			// 产生内部的些链接
			for(var i=interval[0]; i<interval[1]; i++) {
				appendItem(i);
			}
			// 产生结束点
			if (interval[1] < np && opts.num_edge_entries > 0)
			{
				if(np-opts.num_edge_entries > interval[1]&& opts.ellipse_text)
				{
					jQuery("<span>"+opts.ellipse_text+"</span>").appendTo(panel);
				}
				var begin = Math.max(np-opts.num_edge_entries, interval[1]);
				for(var i=begin; i<np; i++) {
					appendItem(i);
				}
				
			}
			// 产生 "Next"-链接
			if(opts.next_text && (current_page < np-1 || opts.next_show_always)){
				appendItem(current_page+1,{text:opts.next_text, classes:"next"});
			}

			if(opts.last_text && (current_page < np-1 || opts.next_show_always)){
				appendItem(numPages()-1,{text:opts.last_text, classes:"next last_text"});
			}
            // var lnk_select = jQuery("<span>每页显示:</span><select id='pageNum'><option selected value= '20' >20</option><option value='50'>50</option><option value='100'>100</option></select><span>条</span>")
				// .bind("change",function () {
				// 	items_per_page = $('#pageNum').val();
				// 	opts.items_per_page = items_per_page;
				// 	drawLinks();
				//     // //opts.callback(current_page, items_per_page, this);
				//     $('#pageNum').val(items_per_page);
            // });
			var lnk_select = jQuery("<span>&nbsp;共&nbsp;[<span id='totalTaskNum'>"+maxentries+"</span>]&nbsp;条,</span><span>每页显示:</span><select id='pageNum'><option selected value= '10' >10</option><option value='20'>20</option><option value='50'>50</option></select><span>条</span>")
				.bind("change",function () {
					items_per_page = $('#pageNum').val();
					opts.items_per_page = items_per_page;
					drawLinks();
				    opts.callback(current_page, items_per_page, maxPage, this);
				    // $('#pageNum').val(items_per_page);
            });
			var lnk_go = jQuery("<span>跳转至:</span><input id='goToPage'></input><span>页</span>");

			var lnk_go_button = jQuery("<a id='go'>前往</a>").bind("click", function () {
					inputGoToNewPage($("#goToPage").val());
            });
				// panel.append(totalTasks);
				panel.append(lnk_select);
				panel.append(lnk_go);
				panel.append(lnk_go_button);
		}

		
		//从选项中提取current_page
		var current_page = opts.current_page;
		var items_per_page = opts.items_per_page;
		//创建一个显示条数和每页显示条数值
		maxentries = (!maxentries || maxentries < 0)?0:maxentries;
		opts.items_per_page = (!opts.items_per_page || opts.items_per_page < 0)?1:opts.items_per_page;
		//存储DOM元素，以方便从所有的内部结构中获取
		var panel = jQuery(this);
		var page = 0;
		// 获得附加功能的元素
		// this.selectPage = function(page_id){ pageSelected(page_id);}
		// this.prevPage = function(){
		// 	if (current_page > 0) {
		// 		pageSelected(current_page - 1);
		// 		return true;
		// 	}
		// 	else {
		// 		return false;
		// 	}
		// }
		// this.nextPage = function(){
		// 	if(current_page < numPages()-1) {
		// 		pageSelected(current_page+1);
		// 		return true;
		// 	}
		// 	else {
		// 		return false;
		// 	}
		// }
		// 所有初始化完成，绘制链接
		// $('#pageNum').val(items_per_page);
		drawLinks();
        // 回调函数
        opts.callback(current_page,items_per_page, maxPage,this);
	});
}


