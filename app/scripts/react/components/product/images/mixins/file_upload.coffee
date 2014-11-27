ACCEPT_FILE_TYPES   = /(\.|\/)(gif|jpe?g|png)$/i
MAX_FILE_SIZE       = 10 * 1000 * 1000
MAX_NUMBER_OF_FILES = 6

FileUploadMixin =

  propTypes:
    onImagesAdd: React.PropTypes.func.isRequired

  componentDidMount: ->
    $fileInput = $(@refs.fileInput.getDOMNode())

    $fileInput.on 'fileuploadadd', @addFilesToForm

    $fileInput.fileupload
      acceptFileTypes:   ACCEPT_FILE_TYPES
      maxFileSize:       MAX_FILE_SIZE
      maxNumberOfFiles:  MAX_NUMBER_OF_FILES
      singleFileUploads: false
      autoUpload:        false
      replaceFileInput:  false
      pasteZone:         null

  componentWillUnmount: ->
    $fileInput.off 'fileuploadadd', @addFilesToForm

  addFilesToForm: (e, data) ->
    images = data.files.map (file) ->
      return {
        id:   null
        uuid: UuidService.generate()
        src:  window.URL.createObjectURL file
        file: file
      }

    @props.onImagesAdd images

module.exports = FileUploadMixin