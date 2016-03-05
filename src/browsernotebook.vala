using Gtk;
using WebKit;

public class BrowserNotebook: Notebook {
	
	private BrowserWindow browserwindow;

	public BrowserNotebook(BrowserWindow browserwindow) {
		//this.change_current_page.connect(this.on_current_page_changed);
		this.browserwindow = browserwindow;
		new_tab();
	}

	public void new_tab() {
		WebView webview = new WebView();
		webview.load_changed.connect(this.on_webview_load_changed);
		this.append_page(webview, new BrowserTabSign());
		this.show_all();
	}

	public ScrolledWindow get_current_scrolledwindow() {
		return this.get_nth_page(this.get_current_page()) as ScrolledWindow;
	}

	public WebView get_current_webview() {
		return this.get_nth_page(this.get_current_page()) as WebView;
	}
	
	private void on_webview_load_changed(LoadEvent loadevent) {
		switch (loadevent) {
			case LoadEvent.STARTED:
				stdout.printf("started\n");
				break;
			case LoadEvent.REDIRECTED:
				stdout.printf("redirected\n");
				break;
			case LoadEvent.COMMITTED:
				stdout.printf("committed\n");
				break;
			case LoadEvent.FINISHED:
				stdout.printf("finished\n");
				this.url_of_current_page_update();
				//BrowserTabSign tab_label = this.get_tab_label(webview) as BrowserTabSign;
				//tab_label.set_title(title);
				break;
		}
	}
	
	/*private void switch_page(int index) {
		WebView webview = this.get_nth_page(index) as WebView;
		string title = webview.get_title();
		this.browserwindow.set_title(title);
	}*/

	private BrowserTabSign get_current_label() {
		return this.get_label(this.get_current_page());
	}

	private BrowserTabSign get_label(int index) {
		return this.get_tab_label(this.get_widget(index)) as BrowserTabSign;
	}

	private WebView get_current_widget() {
		return this.get_widget(this.get_current_page());
	}

	private WebView get_widget(int index) {
		return this.get_nth_page(index) as WebView;
	}

	private void url_of_current_page_update() {
		WebView webview = this.get_current_widget() as WebView;
		BrowserTabSign browsertabsign = this.get_current_label();
		string webview_uri = webview.get_uri();
		string webview_title = webview.get_title();
		browsertabsign.set_label_text(webview_title);
		this.browserwindow.set_entry_text(webview_uri);
	}

	public string http_autocorrect(string uri) {
		if( !("http://" in uri)) {
			if( "https://" in uri){
				return uri;
			}
			var builder = new StringBuilder();
			builder.prepend("http://");
			builder.append(uri);
			return builder.str;
		} else {
			return uri;
		}
	}
}	
