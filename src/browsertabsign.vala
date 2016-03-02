using Gtk;

static const string ICON_TAB = "applications-internet";
static const string ICON_CLOSE = "window-close";
static const string LABEL_TAB = "New tab";

public class BrowserTabSign: Box {

	private Image favicon;
	private Label title;
	private Button closebutton;

    public BrowserTabSign() {
		favicon = new Image.from_icon_name(ICON_TAB);
		title = new Label(LABEL_TAB);
		closebutton = new Button.from_icon_name(ICON_CLOSE,
												IconSize.SMALL_TOOLBAR);
        this.pack_start(favicon, IconSize.SMALL_TOOLBAR), true, true);
        this.pack_start(title, true, true);
        this.pack_start(closebutton, true, true);
		this.show_all();
    }

	public void change_title(string title) {
		this.title.set_text(title);
	}
}
        
