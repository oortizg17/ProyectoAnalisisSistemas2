import React, {Component} from 'react';
import styles from './App.css';


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
					 <h1 className='container'>Listado de Personas</h1>
					 <div className='container'>
						<table className='table table-striped table-dark'>
							<thead>
								<tr>
									<td>#</td>
									<td>Nombre</td>
									<td>Email</td>
									<td>Imagen</td>

								</tr>
							</thead>
							<tbody>
								{items.map(item => (
									<tr key={item.id}>
										<td>
											{item.id}
										</td>
										<td>
											{item.first_name} {item.last_name}
										</td>
										<td>
											{item.email}
										</td>
										<td>
											<img src={item.avatar} alt="Logo" width="50" height="50"></img>
										</td>

									</tr>
								))}
							</tbody>
						</table>						 
					 </div>			
				</div>

		
			);
		}
	}
}
export default App;
