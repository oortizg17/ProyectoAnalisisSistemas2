import React, {Component} from 'react';

class App extends Component {
constructor(props){
  super(props);
  this.state = {
    items: [],
    isLoaded: false,
  }
}
componentWillMount() {
  fetch ('https://reqres.in/api/users')
  .then(res => res.json())
  .then(json => {
    this.setState({
      isLoaded: true,
      items: json.data,
    })
  })
}
render() {
  var { isLoaded, items} = this.state;
  if(!isLoaded){
    return <div>Loading...</div>;
  }
  else{
    return ( 
      <div className= "App"> 
     <ul>
       {items.map(item => (
         <li key={item.id}>
          Email: {item.email}
         </li>
       ))}
     </ul>
      </div>
    );
  }
}
}
export default App;
