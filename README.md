# How to Replace React Components With PureScript's React Libraries

Working through this blog post by Thomas Honeyman: https://thomashoneyman.com/articles/replace-react-components-with-purescript/

### Usage

- Build with `npm i; spago build`
- Make a symbolic link for PureScript output folder so Create React App webpack server can access it.
  ```
  $ ln -s output src/output
  ```
- Run the app with `npm start`
