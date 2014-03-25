# verne

**a markdown driven, file based wiki engine.**

## Installation

Clone the repository to your computer:

```sh
$ git clone https://github.com/256dpi/verne.git
```

Install dependencies:

```sh
$ cd verne
$ bundle install
```

Create a config gile (~/.verne.json):

```javascript
{
  "projects": {
    "wiki-id" : {
      "name": "My Wiki",
      "path": "/path/to/my/wiki"
    }
  }
}
```

Start the server using pow and powder:

```sh
$ powder link
```

Start the server manually:

```sh
$ rackup
```

Open the website in the browser as shown by your favorite tool.

## Special Features

Integrate pdf's or other files through iframes:

    <<some.pdf>>

For integrating other html files use an expanded iframe:

    <<<some.html>>>
