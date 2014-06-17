Case = {
  launchAddLabel: function(caseId){
    $('#add_label_modal').modal('show');
    
    $.get( "cases/"+caseId, function( data ) {
      $( "#label-modal-content" ).html( data );
    });
  },
};

$(function(){
  $( "#label-modal-body" ).html( "<p>Loading Case...</p>" ); // init on load
  
  // clear when dismissed so no remnants exist
  $('#add_label_modal').on('hidden.bs.modal', function (e) {
    $( "#label-modal-body" ).html( "<p>Loading Case...</p>" );
  });
   
});
