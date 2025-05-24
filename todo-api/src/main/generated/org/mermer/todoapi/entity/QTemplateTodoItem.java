package org.mermer.todoapi.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;
import org.mermer.todoapi.entity.enumeration.ContentType;


/**
 * QTemplateTodoItem is a Querydsl query type for TemplateTodoItem
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QTemplateTodoItem extends EntityPathBase<TemplateTodoItem> {

    private static final long serialVersionUID = -1481994208L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QTemplateTodoItem templateTodoItem = new QTemplateTodoItem("templateTodoItem");

    public final QBaseEntity _super;

    public final StringPath contents = createString("contents");

    public final EnumPath<ContentType> contentType = createEnum("contentType", ContentType.class);

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createAt;

    // inherited
    public final QTimeUser createdBy;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final QTimeLineTemplate timeLineTemplate;

    public final StringPath title = createString("title");

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updateAt;

    public QTemplateTodoItem(String variable) {
        this(TemplateTodoItem.class, forVariable(variable), INITS);
    }

    public QTemplateTodoItem(Path<? extends TemplateTodoItem> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QTemplateTodoItem(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QTemplateTodoItem(PathMetadata metadata, PathInits inits) {
        this(TemplateTodoItem.class, metadata, inits);
    }

    public QTemplateTodoItem(Class<? extends TemplateTodoItem> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this._super = new QBaseEntity(type, metadata, inits);
        this.createAt = _super.createAt;
        this.createdBy = _super.createdBy;
        this.timeLineTemplate = inits.isInitialized("timeLineTemplate") ? new QTimeLineTemplate(forProperty("timeLineTemplate"), inits.get("timeLineTemplate")) : null;
        this.updateAt = _super.updateAt;
    }

}

