import React              from "react";
import { connect }        from "react-redux";

const mapStateToProps = (state) => {
  return {

  }
};

const mapDispatchToProps = (state) => {
  return {

  }
};

class AppContainer extends React.Component {
  render() {
    return (
      <h1>Hello React</h1>
    );
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(AppContainer)
