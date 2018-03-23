import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';
import classnames from 'classnames';

export default function game_init(root, channel) {
  ReactDOM.render(<Othello channel={channel} />, root);
}

function getTiles() {
  
  var tiles = [];
  for (var i=0; i < 64; i++) {
    tiles.push({ index: i,
                 val: 0,
               })
  }

 tiles[27].val = 2;
 tiles[28].val = 1;
 tiles[36].val = 2;
 tiles[35].val = 1;
 return tiles;

}


class Othello extends React.Component{
     
    constructor(props) {
        super(props);
        this.channel = props.channel;
        this.player_id;
        this.playername;
        this.flag=0;
        this.state = {
          tiles: getTiles(),
          is_player1: true,
          player1: null,
          player2: null,
          spectators: [],
          player_count: 0,
          p1_score: 2,
          p2_score: 2,
          pos1: true,
          pos2: true,
          alert_message: " ",
        };

        this.channel.join()
                .receive("ok", this.getView.bind(this))
                .receive("error", resp => { console.log("Unable to join", resp)});
    }

    getView(view) {
    this.setState(view.game);
    this.channel.on("PlayerMadeAMove", msg =>{
      this.setState({tiles: msg.tiles})
      this.setState({pos1: msg.pos1})
      this.setState({pos2: msg.pos2})
      this.setState({winner: msg.winner})
      this.setState({p1_score: msg.p1_score})
      this.setState({alert_message: msg.alert_message})
      this.setState({p2_score: msg.p2_score})
    });

    this.channel.on("PlayerJoined", msg =>{
      this.setState({player1: msg.player1})
      this.setState({player2: msg.player2})
      this.setState({alert_message: msg.alert_message})
      this.setState({player_count: msg.player_count})
    });

    this.channel.on("QuitGame", msg =>{
      this.setState({winner: msg.winner})
    });

    }

    playing(tile) {
    this.channel.push("tile", {tile: tile, id: this.player_id})
                        .receive("ok", this.getView.bind(this));
    }

    reset(){
      this.channel.push("restart", {id: this.player_id})
                        .receive("ok",this.getView.bind(this));
    }
    
    playerJoin(){
      if (this.flag==0)
      {
        this.player_id = this.state.player_count + 1;
        this.flag = 1;
        this.channel.push("playerupdate",{playername: this.playername, player_count: this.state.player_count + 1})
                        .receive("ok",this.getView.bind(this));  
      }
    }

    renderTile(tile) {
    var cls = classnames({
      'disc-wh': tile.val == 2,
      'disc-bl': tile.val == 1
    });
    
    return (
            <Button className="lgButtons" onClick={()=>this.playing(tile, this.id)}>
              {(<h4 className={cls}></h4>)}
            </Button>
          );
    }

    renderQuitButton(){
      return (
        <Button className="resetButtons" onClick={()=>this.reset()}>
          Quit Game
        </Button>
      );
    }

    getWinner(){
      if(this.player_id == this.state.winner){
        return "You Won!!"
      }
      else if(this.state.winner == 0)
      {
        return "Still Playing"
      }
      else
      {
        return "Your Opponent Won!!"
      }
      
    }

    updatePlayerValue(ev){
      if(this.flag==0){
        this.playername = ev.target.value;
      }
    }

    



      render(){
        var tiles = this.state.tiles;
        return(
            <div>
            <div className="container board">
                <div className="card-deck">
                  {this.renderTile(tiles[0])}
                  {this.renderTile(tiles[1])}
                  {this.renderTile(tiles[2])}
                  {this.renderTile(tiles[3])}
                  {this.renderTile(tiles[4])}
                  {this.renderTile(tiles[5])}
                  {this.renderTile(tiles[6])}
                  {this.renderTile(tiles[7])}
                </div>
                <div className="card-deck" >
                  {this.renderTile(tiles[8])}
                  {this.renderTile(tiles[9])}
                  {this.renderTile(tiles[10])}
                  {this.renderTile(tiles[11])}
                  {this.renderTile(tiles[12])}
                  {this.renderTile(tiles[13])}
                  {this.renderTile(tiles[14])}
                  {this.renderTile(tiles[15])}
                </div>
                <div className="card-deck">
                  {this.renderTile(tiles[16])}
                  {this.renderTile(tiles[17])}
                  {this.renderTile(tiles[18])}
                  {this.renderTile(tiles[19])}
                  {this.renderTile(tiles[20])}
                  {this.renderTile(tiles[21])}
                  {this.renderTile(tiles[22])}
                  {this.renderTile(tiles[23])}
                </div>
                <div className="card-deck">
                  {this.renderTile(tiles[24])}
                  {this.renderTile(tiles[25])}
                  {this.renderTile(tiles[26])}
                  {this.renderTile(tiles[27])}
                  {this.renderTile(tiles[28])}
                  {this.renderTile(tiles[29])}
                  {this.renderTile(tiles[30])}
                  {this.renderTile(tiles[31])}
                </div>
                <div className="card-deck">
                  {this.renderTile(tiles[32])}
                  {this.renderTile(tiles[33])}
                  {this.renderTile(tiles[34])}
                  {this.renderTile(tiles[35])}
                  {this.renderTile(tiles[36])}
                  {this.renderTile(tiles[37])}
                  {this.renderTile(tiles[38])}
                  {this.renderTile(tiles[39])}
                </div>
                <div className="card-deck" >
                  {this.renderTile(tiles[40])}
                  {this.renderTile(tiles[41])}
                  {this.renderTile(tiles[42])}
                  {this.renderTile(tiles[43])}
                  {this.renderTile(tiles[44])}
                  {this.renderTile(tiles[45])}
                  {this.renderTile(tiles[46])}
                  {this.renderTile(tiles[47])}
                </div>
                <div className="card-deck">
                  {this.renderTile(tiles[48])}
                  {this.renderTile(tiles[49])}
                  {this.renderTile(tiles[50])}
                  {this.renderTile(tiles[51])}
                  {this.renderTile(tiles[52])}
                  {this.renderTile(tiles[53])}
                  {this.renderTile(tiles[54])}
                  {this.renderTile(tiles[55])}
                </div>
                <div className="card-deck">
                  {this.renderTile(tiles[56])}
                  {this.renderTile(tiles[57])}
                  {this.renderTile(tiles[58])}
                  {this.renderTile(tiles[59])}
                  {this.renderTile(tiles[60])}
                  {this.renderTile(tiles[61])}
                  {this.renderTile(tiles[62])}
                  {this.renderTile(tiles[63])}
                </div>

                <div className ="playerJoin">
                  <h3>Enter your name:</h3>
                </div>
                <div className="playerJoinIp">
                    <input type="text" onChange={(ev) => this.updatePlayerValue(ev)} name="playername"/>
                </div>
                <div>
                    <Button className = "playerJoinBt" onClick = {() => this.playerJoin()} >Join Game</Button>
                </div>
            </div>
            <div className = "container player">
                
                <div className="whiteScore">
                  <p>Black Score - {this.state.p1_score}</p>
                </div>

                <div className="whiteScore">
                  <p>White Score - {this.state.p2_score}</p>
                </div>

                <div className = "Winner">
                  <p>Winner is - {this.getWinner()} </p>
                </div>

                <div className = "Player1" >
                  <p>Player 1 - {this.state.player1}</p>
                </div>

                <div className = "Player2" >
                  <p>Player 2 - {this.state.player2}</p>
                </div>

                <div className = "Alert" >
                  <p>Alert Message - {this.state.alert_message}</p>
                </div>
                

              <div className = "myname" >
                  <p>My name - {this.playername}</p>
              </div>

              <div className = "myid" >
                  <p>My ID - {this.player_id}</p>
              </div>

              <div className="reset">
                  {this.renderQuitButton()}
              </div>
            </div>
            </div>
        );
    }
}
