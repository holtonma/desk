Case = {
  launchAddLabel: function(caseId){
    $('#add_label_modal').modal('show');
    
    $.get( "cases/"+caseId, { 'labels[]': this.existingLabels(caseId) }, function( data ) {
      $( "#label-modal-content" ).html( data );
    });
  },
  
  existingLabels: function(caseId){
    // this is for display only, avoid any potential for an additional HTTP request
    var labels = $('.label_'+caseId);
    var output = [];
    var label_text = "";
    for (i = 0; i < labels.length; i++){
      label_text = $(labels[i]).text();
      output.push(label_text);
    }
    
    return output;
  }
};

$(function(){
  $( "#label-modal-body" ).html( "<p>Loading Case...</p>" ); // init on load
  
  // clear when dismissed so no remnants exist
  $('#add_label_modal').on('hidden.bs.modal', function (e) {
    $( "#label-modal-body" ).html( "<p>Loading Case...</p>" );
  });
   
});
