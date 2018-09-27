/*
* Copyright (c) 2018 (https://github.com/phase1geo/Minder)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Trevor Williams <phase1geo@gmail.com>
*/

using GLib;

public class AnimatorNodes : AnimatorAction {

  private Node?              _node = null;
  private AnimatorPositions? _pos  = null;

  /* Default constructor */
  public AnimatorNodes( DrawArea da, Node? n = null, string name = "unnamed" ) {
    base( name );
    _node = n;
    _pos  = new AnimatorPositions( da, n );
  }

  /* Returns the NODES types */
  public override AnimationType type() {
    return( (_node == null) ? AnimationType.NODES : AnimationType.NODE );
  }

  /* Captures the end state */
  public override void capture( DrawArea da ) {
    _pos.gather_new_positions();
  }

  /* Adjusts all of the node positions for the given frame */
  public override void adjust( DrawArea da ) {
    double divisor = index / frames;
    index++;
    for( int i=0; i<_pos.length(); i++ ) {
      double x = _pos.old_x( i ) + ((_pos.new_x( i ) - _pos.old_x( i )) * divisor);
      double y = _pos.old_y( i ) + ((_pos.new_y( i ) - _pos.old_y( i )) * divisor);
      _pos.node( i ).posx = x;
      _pos.node( i ).posy = y;
      _pos.node( i ).side = _pos.node( i ).layout.get_side( _pos.node( i ) );
    }
  }

}

