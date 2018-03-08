import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_othello(root, channel) {
  ReactDOM.render(<Othello />, root);
}

class Othello extends React.Component{
    constructor(props) {
        super(props);
        this.state = {
          p1_score : 0,
          p2_score : 0
        };
      }


      render(){
        return(
            <div className="container">
                <div className="row">
                    <p className="rowLetter"> </p>
                    <p className="rowLetter">A</p>
                    <p className="rowLetter">B</p>
                    <p className="rowLetter">C</p>
                    <p className="rowLetter">D</p>
                    <p className="rowLetter">E</p>
                    <p className="rowLetter">F</p>
                    <p className="rowLetter">G</p>
                    <p className="rowLetter">H</p>
                </div>
                <div className="row">
                        <p className="colLetter">1</p>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                </div>
                <div className="row">
                        <p className="colLetter">2</p>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                </div>
                <div className="row">
                        <p className="colLetter">3</p>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                </div>
                <div className="row">
                        <p className="colLetter">4</p>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                </div>
                <div className="row">
                        <p className="colLetter">5</p>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                </div>
                <div className="row">
                        <p className="colLetter">6</p>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                </div>
                <div className="row">
                        <p className="colLetter">7</p>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                </div>
                <div className="row">
                        <p className="colLetter">8</p>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                        <LightButtons root={this}/>
                        <DarkButtons root={this}/>
                </div>
            </div>
        );
      }

}


function DarkButtons(params){
    let root = params.root;
    return(<Button className="dgButtons"></Button>);
  }

  function LightButtons(params){
    let root = params.root;
    return(<Button className="lgButtons"></Button>);
  }