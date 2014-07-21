" Set font size based on screen size. When vertical height is greater than 900
" " (i.e. an external monitor is attached on 13" or smaller MacBooks), use 18,
" else use 16.
if has('mac')
    if system("osascript -e 'tell application \"Finder\" to get bounds of window of desktop' | cut -d ' ' -f 4") > 900
        set guifont=Monaco:h14
    else
        set guifont=Monaco:h10
    endif
endif

