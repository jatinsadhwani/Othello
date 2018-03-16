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
        this.state = {
          tiles: getTiles(),
          is_player1: true,
          p1_score : 0,
          p2_score : 0
        };

        this.channel.join()
                .receive("ok", this.getView.bind(this))
                .receive("error", resp => { console.log("Unable to join", resp)});
    }

    getView(view) {
    this.setState(view.game);
    }

    playing(tile) {
    this.channel.push("tile", {tile})
                        .receive("ok", this.getView.bind(this));
    }

    renderTile(tile) {
    console.log(tile);
    if(tile.index == 27 || tile.index == 28 || tile.index == 35 || tile.index == 36)
    {
        console.log(tile.index, tile.val);
    }
    var cls = classnames({
      'disc-wh': tile.val == 2,
      'disc-bl': tile.val == 1
    });
    
    return (
            <Button className="lgButtons" onClick={()=>this.playing(tile)}>
              {(<h4 className={cls}></h4>)}
            </Button>
          );
    }


      render(){
        var tiles = this.state.tiles;
        return(
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
            </div>
        );
    }
}
